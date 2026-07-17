import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selida/features/import/data/book_parser.dart';
import 'package:selida/features/import/domain/book_parse_exception.dart';

void main() {
  group('TXT parser', () {
    test('keeps paragraph offsets and detects Greek', () {
      final parsed = parseBookBytes(
        Uint8List.fromList(
          utf8.encode('Πρώτη παράγραφος.\n\nΔεύτερη παράγραφος.'),
        ),
        sourceName: 'δοκιμή.txt',
      );

      expect(parsed.title, 'δοκιμή');
      expect(parsed.language, 'el');
      expect(parsed.chapters, hasLength(1));
      expect(parsed.chapters.single.blocks, hasLength(2));
      expect(parsed.chapters.single.blocks.first.startOffset, 0);
      expect(
        parsed.chapters.single.blocks.last.startOffset,
        parsed.chapters.single.blocks.first.endOffset + 2,
      );
    });

    test('rejects non UTF-8 input with a typed error', () {
      expect(
        () => parseBookBytes(
          Uint8List.fromList(<int>[0xff, 0xfe, 0xfd]),
          sourceName: 'broken.txt',
        ),
        throwsA(
          isA<BookParseException>().having(
            (BookParseException error) => error.code,
            'code',
            BookParseErrorCode.invalidEncoding,
          ),
        ),
      );
    });
  });

  group('EPUB parser', () {
    test('reads EPUB 3 package, nav, metadata, and XHTML blocks', () {
      final parsed = parseBookBytes(_minimalEpub(), sourceName: 'sample.epub');

      expect(parsed.title, 'Μικρή ιστορία');
      expect(parsed.author, 'Δοκιμαστικός Συγγραφέας');
      expect(parsed.language, 'el');
      expect(parsed.chapters, hasLength(1));
      expect(parsed.chapters.single.title, 'Αρχή');
      expect(parsed.chapters.single.blocks, hasLength(3));
      expect(parsed.toc, hasLength(2));
      expect(parsed.toc.first.chapterOrdinal, 0);
      expect(parsed.toc.last.depth, 1);
      expect(parsed.toc.last.textOffset, greaterThan(0));
      expect(parsed.contentHash, hasLength(64));
    });

    test('returns a clear error when container.xml is missing', () {
      final archive = Archive()
        ..add(ArchiveFile.string('mimetype', 'application/epub+zip'));
      final bytes = Uint8List.fromList(ZipEncoder().encode(archive));

      expect(
        () => parseBookBytes(bytes, sourceName: 'broken.epub'),
        throwsA(
          isA<BookParseException>().having(
            (BookParseException error) => error.code,
            'code',
            BookParseErrorCode.invalidContainer,
          ),
        ),
      );
    });
  });
}

Uint8List _minimalEpub() {
  final archive = Archive()
    ..add(ArchiveFile.string('mimetype', 'application/epub+zip'))
    ..add(
      ArchiveFile.string(
        'META-INF/container.xml',
        '''<?xml version="1.0" encoding="UTF-8"?>
<container xmlns="urn:oasis:names:tc:opendocument:xmlns:container" version="1.0">
  <rootfiles>
    <rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml"/>
  </rootfiles>
</container>''',
      ),
    )
    ..add(
      ArchiveFile.string(
        'OEBPS/content.opf',
        '''<?xml version="1.0" encoding="UTF-8"?>
<package xmlns="http://www.idpf.org/2007/opf" version="3.0">
  <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
    <dc:title>Μικρή ιστορία</dc:title>
    <dc:creator>Δοκιμαστικός Συγγραφέας</dc:creator>
    <dc:language>el</dc:language>
  </metadata>
  <manifest>
    <item id="nav" href="nav.xhtml" media-type="application/xhtml+xml" properties="nav"/>
    <item id="chapter" href="chapter.xhtml" media-type="application/xhtml+xml"/>
  </manifest>
  <spine><itemref idref="chapter"/></spine>
</package>''',
      ),
    )
    ..add(
      ArchiveFile.string(
        'OEBPS/nav.xhtml',
        '''<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"><body>
  <nav epub:type="toc" xmlns:epub="http://www.idpf.org/2007/ops">
    <ol>
      <li>
        <a href="chapter.xhtml">Αρχή</a>
        <ol><li><a href="chapter.xhtml#today">Σήμερα</a></li></ol>
      </li>
    </ol>
  </nav>
</body></html>''',
      ),
    )
    ..add(
      ArchiveFile.string(
        'OEBPS/chapter.xhtml',
        '''<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"><body>
  <h1>Αρχή</h1>
  <p>Χθες διάβαζα ένα ενδιαφέρον βιβλίο.</p>
  <p id="today">Σήμερα συνεχίζω την ιστορία.</p>
</body></html>''',
      ),
    );
  return Uint8List.fromList(ZipEncoder().encode(archive));
}
