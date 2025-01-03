@echo off
REM The following variables are Base64 encoded strings for unrpyc and rpatool
REM Due to batch limitations on variable lengths, they need to be split into
REM multiple variables, and joined later using powershell.
REM --------------------------------------------------------------------------------
REM rpatool f2520ad - https://github.com/Shizmob/rpatool
REM --------------------------------------------------------------------------------
set rpatool1=IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwoKZnJvbSBfX2Z1dHVyZV9fIGltcG9ydCBwcmludF9mdW5jdGlvbgoKaW1wb3J0IHN5cwppbXBvcnQgb3MKaW1wb3J0IGNvZGVjcwppbXBvcnQgcGlja2xlCmltcG9ydCBlcnJubwppbXBvcnQgcmFuZG9tCnRyeToKICAgIGltcG9ydCBwaWNrbGU1IGFzIHBpY2tsZQpleGNlcHQ6CiAgICBpbXBvcnQgcGlja2xlCiAgICBpZiBzeXMudmVyc2lvbl9pbmZvIDwgKDMsIDgpOgogICAgICAgIHByaW50KCd3YXJuaW5nOiBwaWNrbGU1IG1vZHVsZSBjb3VsZCBub3QgYmUgbG9hZGVkIGFuZCBQeXRob24gdmVyc2lvbiBpcyA8IDMuOCwnLCBmaWxlPXN5cy5zdGRlcnIpCiAgICAgICAgcHJpbnQoJyAgICAgICAgIG5ld2VyIFJlblwnUHkgZ2FtZXMgbWF5IGZhaWwgdG8gdW5wYWNrIScsIGZpbGU9c3lzLnN0ZGVycikKICAgICAgICBpZiBzeXMudmVyc2lvbl9pbmZvID49ICgzLCA1KToKICAgICAgICAgICAgcHJpbnQoJyAgICAgICAgIGlmIHRoaXMgb2NjdXJzLCBmaXggaXQgYnkgaW5zdGFsbGluZyBwaWNrbGU1OicsIGZpbGU9c3lzLnN0ZGVycikKICAgICAgICAgICAgcHJpbnQoJyAgICAgICAgICAgICB7fSAtbSBwaXAgaW5zdGFsbCBwaWNrbGU1Jy5mb3JtYXQoc3lzLmV4ZWN1dGFibGUpLCBmaWxlPXN5cy5zdGRlcnIpCiAgICAgICAgZWxzZToKICAgICAgICAgICAgcHJpbnQoJyAgICAgICAgIGlmIHRoaXMgb2NjdXJzLCBwbGVhc2UgdXBncmFkZSB0byBhIG5ld2VyIFB5dGhvbiAoPj0gMy41KS4nLCBmaWxlPXN5cy5zdGRlcnIpCiAgICAgICAgcHJpbnQoZmlsZT1zeXMuc3RkZXJyKQoKCmlmIHN5cy52ZXJzaW9uX2luZm9bMF0gPj0gMzoKICAgIGRlZiBfdW5pY29kZSh0ZXh0KToKICAgICAgICByZXR1cm4gdGV4dAoKICAgIGRlZiBfcHJpbnRhYmxlKHRleHQpOgogICAgICAgIHJldHVybiB0ZXh0CgogICAgZGVmIF91bm1hbmdsZShkYXRhKToKICAgICAgICBpZiB0eXBlKGRhdGEpID09IGJ5dGVzOgogICAgICAgICAgICByZXR1cm4gZGF0YQogICAgICAgIGVsc2U6CiAgICAgICAgICAgIHJldHVybiBkYXRhLmVuY29kZSgnbGF0aW4xJykKCiAgICBkZWYgX3VucGlja2xlKGRhdGEpOgogICAgICAgICMgU3BlY2lmeSBsYXRpbjEgZW5jb2RpbmcgdG8gcHJldmVudCByYXcgYnl0ZSB2YWx1ZXMgZnJvbSBjYXVzaW5nIGFuIEFTQ0lJIGRlY29kZSBlcnJvci4KICAgICAgICByZXR1cm4gcGlja2xlLmxvYWRzKGRhdGEsIGVuY29kaW5nPSdsYXRpbjEnKQplbGlmIHN5cy52ZXJzaW9uX2luZm9bMF0gPT0gMjoKICAgIGRlZiBfdW5pY29kZSh0ZXh0KToKICAgICAgICBpZiBpc2luc3RhbmNlKHRleHQsIHVuaWNvZGUpOgogICAgICAgICAgICByZXR1cm4gdGV4dAogICAgICAgIHJldHVybiB0ZXh0LmRlY29kZSgndXRmLTgnKQoKICAgIGRlZiBfcHJpbnRhYmxlKHRleHQpOgogICAgICAgIHJldHVybiB0ZXh0LmVuY29kZSgndXRmLTgnKQoKICAgIGRlZiBfdW5tYW5nbGUoZGF0YSk6CiAgICAgICAgcmV0dXJuIGRhdGEKCiAgICBkZWYgX3VucGlja2xlKGRhdGEpOgogICAgICAgIHJldHVybiBwaWNrbGUubG9hZHMoZGF0YSkKCmNsYXNzIFJlblB5QXJjaGl2ZToKICAgIGZpbGUgPSBOb25lCiAgICBoYW5kbGUgPSBOb25lCgogICAgZmlsZXMgPSB7fQogICAgaW5kZXhlcyA9IHt9CgogICAgdmVyc2lvbiA9IE5vbmUKICAgIHBhZGxlbmd0aCA9IDAKICAgIGtleSA9IE5vbmUKICAgIHZlcmJvc2UgPSBGYWxzZQoKICAgIFJQQTJfTUFHSUMgPSAnUlBBLTIuMCAnCiAgICBSUEEzX01BR0lDID0gJ1JQQS0zLjAgJwogICAgUlBBM18yX01BR0lDID0gJ1JQQS0zLjIgJwoKICAgICMgRm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHksIG90aGVyd2lzZSBQeXRob24zLXBhY2tlZCBhcmNoaXZlcyB3b24ndCBiZSByZWFkIGJ5IFB5dGhvbjIKICAgIFBJQ0tMRV9QUk9UT0NPTCA9IDIKCiAgICBkZWYgX19pbml0X18oc2VsZiwgZmlsZSA9IE5vbmUsIHZlcnNpb24gPSAzLCBwYWRsZW5ndGggPSAwLCBrZXkgPSAweERFQURCRUVGLCB2ZXJib3NlID0gRmFsc2UpOgogICAgICAgIHNlbGYucGFkbGVuZ3RoID0gcGFkbGVuZ3RoCiAgICAgICAgc2VsZi5rZXkgPSBrZXkKICAgICAgICBzZWxmLnZlcmJvc2UgPSB2ZXJib3NlCgogICAgICAgIGlmIGZpbGUgaXMgbm90IE5vbmU6CiAgICAgICAgICAgIHNlbGYubG9hZChmaWxlKQogICAgICAgIGVsc2U6CiAgICAgICAgICAgIHNlbGYudmVyc2lvbiA9IHZlcnNpb24KCiAgICBkZWYgX19kZWxfXyhzZWxmKToKICAgICAgICBpZiBzZWxmLmhhbmRsZSBpcyBub3QgTm9uZToKICAgICAgICAgICAgc2VsZi5oYW5kbGUuY2xvc2UoKQoKICAgICMgRGV0ZXJtaW5lIGFyY2hpdmUgdmVyc2lvbi4KICAgIGRlZiBnZXRfdmVyc2lvbihzZWxmKToKICAgICAgICBzZWxmLmhhbmRsZS5zZWVrKDApCiAgICAgICAgbWFnaWMgPSBzZWxmLmhhbmRsZS5yZWFkbGluZSgpLmRlY29kZSgndXRmLTgnKQoKICAgICAgICBpZiBtYWdpYy5zdGFydHN3aXRoKHNlbGYuUlBBM18yX01BR0lDKToKICAgICAgICAgICAgcmV0dXJuIDMuMgogICAgICAgIGVsaWYgbWFnaWMuc3RhcnRzd2l0aChzZWxmLlJQQTNfTUFHSUMpOgogICAgICAgICAgICByZXR1cm4gMwogICAgICAgIGVsaWYgbWFnaWMuc3RhcnRzd2l0aChzZWxmLlJQQTJfTUFHSUMpOgogICAgICAgICAgICByZXR1cm4gMgogICAgICAgIGVsaWYgc2VsZi5maWxlLmVuZHN3aXRoKCcucnBpJyk6CiAgICAgICAgICAgIHJldHVybiAxCgogICAgICAgIHJhaXNlIFZhbHVlRXJyb3IoJ3RoZSBnaXZlbiBmaWxlIGlzIG5vdCBhIHZhbGlkIFJlblwnUHkgYXJjaGl2ZSwgb3IgYW4gdW5zdXBwb3J0ZWQgdmVyc2lvbicpCgogICAgIyBFeHRyYWN0IGZpbGUgaW5kZXhlcyBmcm9tIG9wZW5lZCBhcmNoaXZlLgogICAgZGVmIGV4dHJhY3RfaW5kZXhlcyhzZWxmKToKICAgICAgICBzZWxmLmhhbmRsZS5zZWVrKDApCiAgICAgICAgaW5kZXhlcyA9IE5vbmUKCiAgICAgICAgaWYgc2VsZi52ZXJzaW9uIGluIFsyLCAzLCAzLjJdOgogICAgICAgICAgICAjIEZldGNoIG1ldGFkYXRhLgogICAgICAgICAgICBtZXRhZGF0YSA9IHNlbGYuaGFuZGxlLnJlYWRsaW5lKCkKICAgICAgICAgICAgdmFscyA9IG1ldGFkYXRhLnNwbGl0KCkKICAgICAgICAgICAgb2Zmc2V0ID0gaW50KHZhbHNbMV0sIDE2KQogICAgICAgICAgICBpZiBzZWxmLnZlcnNpb24gPT0gMzoKICAgICAgICAgICAgICAgIHNlbGYua2V5ID0gMAogICAgICAgICAgICAgICAgZm9yIHN1YmtleSBpbiB2YWxzWzI6XToKICAgICAgICAgICAgICAgICAgICBzZWxmLmtleSBePSBpbnQoc3Via2V5LCAxNikKICAgICAgICAgICAgZWxpZiBzZWxmLnZlcnNpb24gPT0gMy4yOgogICAgICAgICAgICAgICAgc2VsZi5rZXkgPSAwCiAgICAgICAgICAgICAgICBmb3Igc3Via2V5IGluIHZhbHNbMzpdOgogICAgICAgICAgICAgICAgICAgIHNlbGYua2V5IF49IGludChzdWJrZXksIDE2KQoKICAgICAgICAgICAgIyBMb2FkIGluIGluZGV4ZXMuCiAgICAgICAgICAgIHNlbGYuaGFuZGxlLnNlZWsob2Zmc2V0KQogICAgICAgICAgICBjb250ZW50cyA9IGNvZGVjcy5kZWNvZGUoc2VsZi5oYW5kbGUucmVhZCgpLCAnemxpYicpCiAgICAgICAgICAgIGluZGV4ZXMgPSBfdW5waWNrbGUoY29udGVudHMpCgogICAgICAg
set rpatool2=ICAgICAjIERlb2JmdXNjYXRlIGluZGV4ZXMuCiAgICAgICAgICAgIGlmIHNlbGYudmVyc2lvbiBpbiBbMywgMy4yXToKICAgICAgICAgICAgICAgIG9iZnVzY2F0ZWRfaW5kZXhlcyA9IGluZGV4ZXMKICAgICAgICAgICAgICAgIGluZGV4ZXMgPSB7fQogICAgICAgICAgICAgICAgZm9yIGkgaW4gb2JmdXNjYXRlZF9pbmRleGVzLmtleXMoKToKICAgICAgICAgICAgICAgICAgICBpZiBsZW4ob2JmdXNjYXRlZF9pbmRleGVzW2ldWzBdKSA9PSAyOgogICAgICAgICAgICAgICAgICAgICAgICBpbmRleGVzW2ldID0gWyAob2Zmc2V0IF4gc2VsZi5rZXksIGxlbmd0aCBeIHNlbGYua2V5KSBmb3Igb2Zmc2V0LCBsZW5ndGggaW4gb2JmdXNjYXRlZF9pbmRleGVzW2ldIF0KICAgICAgICAgICAgICAgICAgICBlbHNlOgogICAgICAgICAgICAgICAgICAgICAgICBpbmRleGVzW2ldID0gWyAob2Zmc2V0IF4gc2VsZi5rZXksIGxlbmd0aCBeIHNlbGYua2V5LCBwcmVmaXgpIGZvciBvZmZzZXQsIGxlbmd0aCwgcHJlZml4IGluIG9iZnVzY2F0ZWRfaW5kZXhlc1tpXSBdCiAgICAgICAgZWxzZToKICAgICAgICAgICAgaW5kZXhlcyA9IHBpY2tsZS5sb2Fkcyhjb2RlY3MuZGVjb2RlKHNlbGYuaGFuZGxlLnJlYWQoKSwgJ3psaWInKSkKCiAgICAgICAgcmV0dXJuIGluZGV4ZXMKCiAgICAjIEdlbmVyYXRlIHBzZXVkb3JhbmRvbSBwYWRkaW5nIChmb3Igd2hhdGV2ZXIgcmVhc29uKS4KICAgIGRlZiBnZW5lcmF0ZV9wYWRkaW5nKHNlbGYpOgogICAgICAgIGxlbmd0aCA9IHJhbmRvbS5yYW5kaW50KDEsIHNlbGYucGFkbGVuZ3RoKQoKICAgICAgICBwYWRkaW5nID0gJycKICAgICAgICB3aGlsZSBsZW5ndGggPiAwOgogICAgICAgICAgICBwYWRkaW5nICs9IGNocihyYW5kb20ucmFuZGludCgxLCAyNTUpKQogICAgICAgICAgICBsZW5ndGggLT0gMQoKICAgICAgICByZXR1cm4gYnl0ZXMocGFkZGluZywgJ3V0Zi04JykKCiAgICAjIENvbnZlcnRzIGEgZmlsZW5hbWUgdG8gYXJjaGl2ZSBmb3JtYXQuCiAgICBkZWYgY29udmVydF9maWxlbmFtZShzZWxmLCBmaWxlbmFtZSk6CiAgICAgICAgKGRyaXZlLCBmaWxlbmFtZSkgPSBvcy5wYXRoLnNwbGl0ZHJpdmUob3MucGF0aC5ub3JtcGF0aChmaWxlbmFtZSkucmVwbGFjZShvcy5zZXAsICcvJykpCiAgICAgICAgcmV0dXJuIGZpbGVuYW1lCgogICAgIyBEZWJ1ZyAodmVyYm9zZSkgbWVzc2FnZXMuCiAgICBkZWYgdmVyYm9zZV9wcmludChzZWxmLCBtZXNzYWdlKToKICAgICAgICBpZiBzZWxmLnZlcmJvc2U6CiAgICAgICAgICAgIHByaW50KG1lc3NhZ2UpCgoKICAgICMgTGlzdCBmaWxlcyBpbiBhcmNoaXZlIGFuZCBjdXJyZW50IGludGVybmFsIHN0b3JhZ2UuCiAgICBkZWYgbGlzdChzZWxmKToKICAgICAgICByZXR1cm4gbGlzdChzZWxmLmluZGV4ZXMua2V5cygpKSArIGxpc3Qoc2VsZi5maWxlcy5rZXlzKCkpCgogICAgIyBDaGVjayBpZiBhIGZpbGUgZXhpc3RzIGluIHRoZSBhcmNoaXZlLgogICAgZGVmIGhhc19maWxlKHNlbGYsIGZpbGVuYW1lKToKICAgICAgICBmaWxlbmFtZSA9IF91bmljb2RlKGZpbGVuYW1lKQogICAgICAgIHJldHVybiBmaWxlbmFtZSBpbiBzZWxmLmluZGV4ZXMua2V5cygpIG9yIGZpbGVuYW1lIGluIHNlbGYuZmlsZXMua2V5cygpCgogICAgIyBSZWFkIGZpbGUgZnJvbSBhcmNoaXZlIG9yIGludGVybmFsIHN0b3JhZ2UuCiAgICBkZWYgcmVhZChzZWxmLCBmaWxlbmFtZSk6CiAgICAgICAgZmlsZW5hbWUgPSBzZWxmLmNvbnZlcnRfZmlsZW5hbWUoX3VuaWNvZGUoZmlsZW5hbWUpKQoKICAgICAgICAjIENoZWNrIGlmIHRoZSBmaWxlIGV4aXN0cyBpbiBvdXIgaW5kZXhlcy4KICAgICAgICBpZiBmaWxlbmFtZSBub3QgaW4gc2VsZi5maWxlcyBhbmQgZmlsZW5hbWUgbm90IGluIHNlbGYuaW5kZXhlczoKICAgICAgICAgICAgcmFpc2UgSU9FcnJvcihlcnJuby5FTk9FTlQsICd0aGUgcmVxdWVzdGVkIGZpbGUgezB9IGRvZXMgbm90IGV4aXN0IGluIHRoZSBnaXZlbiBSZW5cJ1B5IGFyY2hpdmUnLmZvcm1hdCgKICAgICAgICAgICAgICAgIF9wcmludGFibGUoZmlsZW5hbWUpKSkKCiAgICAgICAgIyBJZiBpdCdzIGluIG91ciBvcGVuZWQgYXJjaGl2ZSBpbmRleCwgYW5kIG91ciBhcmNoaXZlIGhhbmRsZSBpc24ndCB2YWxpZCwgc29tZXRoaW5nIGlzIG9idmlvdXNseSB3cm9uZy4KICAgICAgICBpZiBmaWxlbmFtZSBub3QgaW4gc2VsZi5maWxlcyBhbmQgZmlsZW5hbWUgaW4gc2VsZi5pbmRleGVzIGFuZCBzZWxmLmhhbmRsZSBpcyBOb25lOgogICAgICAgICAgICByYWlzZSBJT0Vycm9yKGVycm5vLkVOT0VOVCwgJ3RoZSByZXF1ZXN0ZWQgZmlsZSB7MH0gZG9lcyBub3QgZXhpc3QgaW4gdGhlIGdpdmVuIFJlblwnUHkgYXJjaGl2ZScuZm9ybWF0KAogICAgICAgICAgICAgICAgX3ByaW50YWJsZShmaWxlbmFtZSkpKQoKICAgICAgICAjIENoZWNrIG91ciBzaW1wbGlmaWVkIGludGVybmFsIGluZGV4ZXMgZmlyc3QsIGluIGNhc2Ugc29tZW9uZSB3YW50cyB0byByZWFkIGEgZmlsZSB0aGV5IGFkZGVkIGJlZm9yZSB3aXRob3V0IHNhdmluZywgZm9yIHNvbWUgdW5ob2x5IHJlYXNvbi4KICAgICAgICBpZiBmaWxlbmFtZSBpbiBzZWxmLmZpbGVzOgogICAgICAgICAgICBzZWxmLnZlcmJvc2VfcHJpbnQoJ1JlYWRpbmcgZmlsZSB7MH0gZnJvbSBpbnRlcm5hbCBzdG9yYWdlLi4uJy5mb3JtYXQoX3ByaW50YWJsZShmaWxlbmFtZSkpKQogICAgICAgICAgICByZXR1cm4gc2VsZi5maWxlc1tmaWxlbmFtZV0KICAgICAgICAjIFdlIG5lZWQgdG8gcmVhZCB0aGUgZmlsZSBmcm9tIG91ciBvcGVuIGFyY2hpdmUuCiAgICAgICAgZWxzZToKICAgICAgICAgICAgIyBSZWFkIG9mZnNldCBhbmQgbGVuZ3RoLCBzZWVrIHRvIHRoZSBvZmZzZXQgYW5kIHJlYWQgdGhlIGZpbGUgY29udGVudHMuCiAgICAgICAgICAgIGlmIGxlbihzZWxmLmluZGV4ZXNbZmlsZW5hbWVdWzBdKSA9PSAzOgogICAgICAgICAgICAgICAgKG9mZnNldCwgbGVuZ3RoLCBwcmVmaXgpID0gc2VsZi5pbmRleGVzW2ZpbGVuYW1lXVswXQogICAgICAgICAgICBlbHNlOgogICAgICAgICAgICAgICAgKG9mZnNldCwgbGVuZ3RoKSA9IHNlbGYuaW5kZXhlc1tmaWxlbmFtZV1bMF0KICAgICAgICAgICAgICAgIHByZWZpeCA9ICcnCgogICAgICAgICAgICBzZWxmLnZlcmJvc2VfcHJpbnQoJ1JlYWRpbmcgZmlsZSB7MH0gZnJvbSBkYXRhIGZpbGUgezF9Li4uIChvZmZzZXQgPSB7Mn0sIGxlbmd0aCA9IHszfSBieXRlcyknLmZvcm1hdCgKICAgICAgICAgICAgICAgIF9wcmludGFibGUoZmlsZW5hbWUpLCBzZWxmLmZpbGUsIG9mZnNldCwgbGVuZ3RoKSkKICAgICAgICAgICAgc2VsZi5oYW5kbGUuc2VlayhvZmZzZXQpCiAgICAgICAgICAgIHJldHVybiBfdW5tYW5nbGUocHJlZml4KSArIHNlbGYuaGFuZGxlLnJlYWQobGVuZ3RoIC0gbGVuKHByZWZpeCkpCgogICAgIyBNb2RpZnkgYSBmaWxlIGluIGFyY2hpdmUgb3IgaW50ZXJuYWwgc3RvcmFnZS4KICAgIGRlZiBjaGFuZ2Uoc2VsZiwgZmlsZW5hbWUsIGNvbnRlbnRzKToKICAgICAgICBmaWxlbmFtZSA9IF91bmljb2RlKGZpbGVuYW1lKQoKICAgICAgICAjIE91ciAnY2hhbmdlJyBpcyBiYXNpY2FsbHkgcmVtb3ZpbmcgdGhlIGZpbGUgZnJvbSBvdXIgaW5kZXhlcyBmaXJz
set rpatool3=dCwgYW5kIHRoZW4gcmUtYWRkaW5nIGl0LgogICAgICAgIHNlbGYucmVtb3ZlKGZpbGVuYW1lKQogICAgICAgIHNlbGYuYWRkKGZpbGVuYW1lLCBjb250ZW50cykKCiAgICAjIEFkZCBhIGZpbGUgdG8gdGhlIGludGVybmFsIHN0b3JhZ2UuCiAgICBkZWYgYWRkKHNlbGYsIGZpbGVuYW1lLCBjb250ZW50cyk6CiAgICAgICAgZmlsZW5hbWUgPSBzZWxmLmNvbnZlcnRfZmlsZW5hbWUoX3VuaWNvZGUoZmlsZW5hbWUpKQogICAgICAgIGlmIGZpbGVuYW1lIGluIHNlbGYuZmlsZXMgb3IgZmlsZW5hbWUgaW4gc2VsZi5pbmRleGVzOgogICAgICAgICAgICByYWlzZSBWYWx1ZUVycm9yKCdmaWxlIHswfSBhbHJlYWR5IGV4aXN0cyBpbiBhcmNoaXZlJy5mb3JtYXQoX3ByaW50YWJsZShmaWxlbmFtZSkpKQoKICAgICAgICBzZWxmLnZlcmJvc2VfcHJpbnQoJ0FkZGluZyBmaWxlIHswfSB0byBhcmNoaXZlLi4uIChsZW5ndGggPSB7MX0gYnl0ZXMpJy5mb3JtYXQoCiAgICAgICAgICAgIF9wcmludGFibGUoZmlsZW5hbWUpLCBsZW4oY29udGVudHMpKSkKICAgICAgICBzZWxmLmZpbGVzW2ZpbGVuYW1lXSA9IGNvbnRlbnRzCgogICAgIyBSZW1vdmUgYSBmaWxlIGZyb20gYXJjaGl2ZSBvciBpbnRlcm5hbCBzdG9yYWdlLgogICAgZGVmIHJlbW92ZShzZWxmLCBmaWxlbmFtZSk6CiAgICAgICAgZmlsZW5hbWUgPSBfdW5pY29kZShmaWxlbmFtZSkKICAgICAgICBpZiBmaWxlbmFtZSBpbiBzZWxmLmZpbGVzOgogICAgICAgICAgICBzZWxmLnZlcmJvc2VfcHJpbnQoJ1JlbW92aW5nIGZpbGUgezB9IGZyb20gaW50ZXJuYWwgc3RvcmFnZS4uLicuZm9ybWF0KF9wcmludGFibGUoZmlsZW5hbWUpKSkKICAgICAgICAgICAgZGVsIHNlbGYuZmlsZXNbZmlsZW5hbWVdCiAgICAgICAgZWxpZiBmaWxlbmFtZSBpbiBzZWxmLmluZGV4ZXM6CiAgICAgICAgICAgIHNlbGYudmVyYm9zZV9wcmludCgnUmVtb3ZpbmcgZmlsZSB7MH0gZnJvbSBhcmNoaXZlIGluZGV4ZXMuLi4nLmZvcm1hdChfcHJpbnRhYmxlKGZpbGVuYW1lKSkpCiAgICAgICAgICAgIGRlbCBzZWxmLmluZGV4ZXNbZmlsZW5hbWVdCiAgICAgICAgZWxzZToKICAgICAgICAgICAgcmFpc2UgSU9FcnJvcihlcnJuby5FTk9FTlQsICd0aGUgcmVxdWVzdGVkIGZpbGUgezB9IGRvZXMgbm90IGV4aXN0IGluIHRoaXMgYXJjaGl2ZScuZm9ybWF0KF9wcmludGFibGUoZmlsZW5hbWUpKSkKCiAgICAjIExvYWQgYXJjaGl2ZS4KICAgIGRlZiBsb2FkKHNlbGYsIGZpbGVuYW1lKToKICAgICAgICBmaWxlbmFtZSA9IF91bmljb2RlKGZpbGVuYW1lKQoKICAgICAgICBpZiBzZWxmLmhhbmRsZSBpcyBub3QgTm9uZToKICAgICAgICAgICAgc2VsZi5oYW5kbGUuY2xvc2UoKQogICAgICAgIHNlbGYuZmlsZSA9IGZpbGVuYW1lCiAgICAgICAgc2VsZi5maWxlcyA9IHt9CiAgICAgICAgc2VsZi5oYW5kbGUgPSBvcGVuKHNlbGYuZmlsZSwgJ3JiJykKICAgICAgICBzZWxmLnZlcnNpb24gPSBzZWxmLmdldF92ZXJzaW9uKCkKICAgICAgICBzZWxmLmluZGV4ZXMgPSBzZWxmLmV4dHJhY3RfaW5kZXhlcygpCgogICAgIyBTYXZlIGN1cnJlbnQgc3RhdGUgaW50byBhIG5ldyBmaWxlLCBtZXJnaW5nIGFyY2hpdmUgYW5kIGludGVybmFsIHN0b3JhZ2UsIHJlYnVpbGRpbmcgaW5kZXhlcywgYW5kIG9wdGlvbmFsbHkgc2F2aW5nIGluIGFub3RoZXIgZm9ybWF0IHZlcnNpb24uCiAgICBkZWYgc2F2ZShzZWxmLCBmaWxlbmFtZSA9IE5vbmUpOgogICAgICAgIGZpbGVuYW1lID0gX3VuaWNvZGUoZmlsZW5hbWUpCgogICAgICAgIGlmIGZpbGVuYW1lIGlzIE5vbmU6CiAgICAgICAgICAgIGZpbGVuYW1lID0gc2VsZi5maWxlCiAgICAgICAgaWYgZmlsZW5hbWUgaXMgTm9uZToKICAgICAgICAgICAgcmFpc2UgVmFsdWVFcnJvcignbm8gdGFyZ2V0IGZpbGUgZm91bmQgZm9yIHNhdmluZyBhcmNoaXZlJykKICAgICAgICBpZiBzZWxmLnZlcnNpb24gIT0gMiBhbmQgc2VsZi52ZXJzaW9uICE9IDM6CiAgICAgICAgICAgIHJhaXNlIFZhbHVlRXJyb3IoJ3NhdmluZyBpcyBvbmx5IHN1cHBvcnRlZCBmb3IgdmVyc2lvbiAyIGFuZCAzIGFyY2hpdmVzJykKCiAgICAgICAgc2VsZi52ZXJib3NlX3ByaW50KCdSZWJ1aWxkaW5nIGFyY2hpdmUgaW5kZXguLi4nKQogICAgICAgICMgRmlsbCBvdXIgb3duIGZpbGVzIHN0cnVjdHVyZSB3aXRoIHRoZSBmaWxlcyBhZGRlZCBvciBjaGFuZ2VkIGluIHRoaXMgc2Vzc2lvbi4KICAgICAgICBmaWxlcyA9IHNlbGYuZmlsZXMKICAgICAgICAjIEZpcnN0LCByZWFkIGZpbGVzIGZyb20gdGhlIGN1cnJlbnQgYXJjaGl2ZSBpbnRvIG91ciBmaWxlcyBzdHJ1Y3R1cmUuCiAgICAgICAgZm9yIGZpbGUgaW4gbGlzdChzZWxmLmluZGV4ZXMua2V5cygpKToKICAgICAgICAgICAgY29udGVudCA9IHNlbGYucmVhZChmaWxlKQogICAgICAgICAgICAjIFJlbW92ZSBmcm9tIGluZGV4ZXMgYXJyYXkgb25jZSByZWFkLCBhZGQgdG8gb3VyIG93biBhcnJheS4KICAgICAgICAgICAgZGVsIHNlbGYuaW5kZXhlc1tmaWxlXQogICAgICAgICAgICBmaWxlc1tmaWxlXSA9IGNvbnRlbnQKCiAgICAgICAgIyBQcmVkaWN0IGhlYWRlciBsZW5ndGgsIHdlJ2xsIHdyaXRlIHRoYXQgb25lIGxhc3QuCiAgICAgICAgb2Zmc2V0ID0gMAogICAgICAgIGlmIHNlbGYudmVyc2lvbiA9PSAzOgogICAgICAgICAgICBvZmZzZXQgPSAzNAogICAgICAgIGVsaWYgc2VsZi52ZXJzaW9uID09IDI6CiAgICAgICAgICAgIG9mZnNldCA9IDI1CiAgICAgICAgYXJjaGl2ZSA9IG9wZW4oZmlsZW5hbWUsICd3YicpCiAgICAgICAgYXJjaGl2ZS5zZWVrKG9mZnNldCkKCiAgICAgICAgIyBCdWlsZCBvdXIgb3duIGluZGV4ZXMgd2hpbGUgd3JpdGluZyBmaWxlcyB0byB0aGUgYXJjaGl2ZS4KICAgICAgICBpbmRleGVzID0ge30KICAgICAgICBzZWxmLnZlcmJvc2VfcHJpbnQoJ1dyaXRpbmcgZmlsZXMgdG8gYXJjaGl2ZSBmaWxlLi4uJykKICAgICAgICBmb3IgZmlsZSwgY29udGVudCBpbiBmaWxlcy5pdGVtcygpOgogICAgICAgICAgICAjIEdlbmVyYXRlIHJhbmRvbSBwYWRkaW5nLCBmb3Igd2hhdGV2ZXIgcmVhc29uLgogICAgICAgICAgICBpZiBzZWxmLnBhZGxlbmd0aCA+IDA6CiAgICAgICAgICAgICAgICBwYWRkaW5nID0gc2VsZi5nZW5lcmF0ZV9wYWRkaW5nKCkKICAgICAgICAgICAgICAgIGFyY2hpdmUud3JpdGUocGFkZGluZykKICAgICAgICAgICAgICAgIG9mZnNldCArPSBsZW4ocGFkZGluZykKCiAgICAgICAgICAgIGFyY2hpdmUud3JpdGUoY29udGVudCkKICAgICAgICAgICAgIyBVcGRhdGUgaW5kZXguCiAgICAgICAgICAgIGlmIHNlbGYudmVyc2lvbiA9PSAzOgogICAgICAgICAgICAgICAgaW5kZXhlc1tmaWxlXSA9IFsgKG9mZnNldCBeIHNlbGYua2V5LCBsZW4oY29udGVudCkgXiBzZWxmLmtleSkgXQogICAgICAgICAgICBlbGlmIHNlbGYudmVyc2lvbiA9PSAyOgogICAgICAgICAgICAgICAgaW5kZXhlc1tmaWxlXSA9IFsgKG9mZnNldCwgbGVuKGNvbnRlbnQpKSBdCiAgICAgICAgICAgIG9mZnNldCArPSBsZW4oY29udGVudCkKCiAgICAgICAgIyBXcml0ZSB0aGUgaW5kZXhlcy4KICAgICAgICBzZWxmLnZlcmJvc2VfcHJpbnQoJ1dyaXRpbmcgYXJjaGl2ZSBpbmRleCB0byBhcmNoaXZlIGZpbGUuLi4nKQogICAgICAgIGFy
set rpatool4=Y2hpdmUud3JpdGUoY29kZWNzLmVuY29kZShwaWNrbGUuZHVtcHMoaW5kZXhlcywgc2VsZi5QSUNLTEVfUFJPVE9DT0wpLCAnemxpYicpKQogICAgICAgICMgTm93IHdyaXRlIHRoZSBoZWFkZXIuCiAgICAgICAgc2VsZi52ZXJib3NlX3ByaW50KCdXcml0aW5nIGhlYWRlciB0byBhcmNoaXZlIGZpbGUuLi4gKHZlcnNpb24gPSBSUEF2ezB9KScuZm9ybWF0KHNlbGYudmVyc2lvbikpCiAgICAgICAgYXJjaGl2ZS5zZWVrKDApCiAgICAgICAgaWYgc2VsZi52ZXJzaW9uID09IDM6CiAgICAgICAgICAgIGFyY2hpdmUud3JpdGUoY29kZWNzLmVuY29kZSgne317OjAxNnh9IHs6MDh4fVxuJy5mb3JtYXQoc2VsZi5SUEEzX01BR0lDLCBvZmZzZXQsIHNlbGYua2V5KSkpCiAgICAgICAgZWxzZToKICAgICAgICAgICAgYXJjaGl2ZS53cml0ZShjb2RlY3MuZW5jb2RlKCd7fXs6MDE2eH1cbicuZm9ybWF0KHNlbGYuUlBBMl9NQUdJQywgb2Zmc2V0KSkpCiAgICAgICAgIyBXZSdyZSBkb25lLCBjbG9zZSBpdC4KICAgICAgICBhcmNoaXZlLmNsb3NlKCkKCiAgICAgICAgIyBSZWxvYWQgdGhlIGZpbGUgaW4gb3VyIGlubmVyIGRhdGFiYXNlLgogICAgICAgIHNlbGYubG9hZChmaWxlbmFtZSkKCmlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICBpbXBvcnQgYXJncGFyc2UKCiAgICBwYXJzZXIgPSBhcmdwYXJzZS5Bcmd1bWVudFBhcnNlcigKICAgICAgICBkZXNjcmlwdGlvbj0nQSB0b29sIGZvciB3b3JraW5nIHdpdGggUmVuXCdQeSBhcmNoaXZlIGZpbGVzLicsCiAgICAgICAgZXBpbG9nPSdUaGUgRklMRSBhcmd1bWVudCBjYW4gb3B0aW9uYWxseSBiZSBpbiBBUkNISVZFPVJFQUwgZm9ybWF0LCBtYXBwaW5nIGEgZmlsZSBpbiB0aGUgYXJjaGl2ZSBmaWxlIHN5c3RlbSB0byBhIGZpbGUgb24geW91ciByZWFsIGZpbGUgc3lzdGVtLiBBbiBleGFtcGxlIG9mIHRoaXM6IHJwYXRvb2wgLXggdGVzdC5ycGEgc2NyaXB0LnJweWM9L2hvbWUvZm9vL3Rlc3QucnB5YycsCiAgICAgICAgYWRkX2hlbHA9RmFsc2UpCgogICAgcGFyc2VyLmFkZF9hcmd1bWVudCgnYXJjaGl2ZScsIG1ldGF2YXI9J0FSQ0hJVkUnLCBoZWxwPSdUaGUgUmVuXCdweSBhcmNoaXZlIGZpbGUgdG8gb3BlcmF0ZSBvbi4nKQogICAgcGFyc2VyLmFkZF9hcmd1bWVudCgnZmlsZXMnLCBtZXRhdmFyPSdGSUxFJywgbmFyZ3M9JyonLCBhY3Rpb249J2FwcGVuZCcsIGhlbHA9J1plcm8gb3IgbW9yZSBmaWxlcyB0byBvcGVyYXRlIG9uLicpCgogICAgcGFyc2VyLmFkZF9hcmd1bWVudCgnLWwnLCAnLS1saXN0JywgYWN0aW9uPSdzdG9yZV90cnVlJywgaGVscD0nTGlzdCBmaWxlcyBpbiBhcmNoaXZlIEFSQ0hJVkUuJykKICAgIHBhcnNlci5hZGRfYXJndW1lbnQoJy14JywgJy0tZXh0cmFjdCcsIGFjdGlvbj0nc3RvcmVfdHJ1ZScsIGhlbHA9J0V4dHJhY3QgRklMRXMgZnJvbSBBUkNISVZFLicpCiAgICBwYXJzZXIuYWRkX2FyZ3VtZW50KCctYycsICctLWNyZWF0ZScsIGFjdGlvbj0nc3RvcmVfdHJ1ZScsIGhlbHA9J0NyZWF0aXZlIEFSQ0hJVkUgZnJvbSBGSUxFcy4nKQogICAgcGFyc2VyLmFkZF9hcmd1bWVudCgnLWQnLCAnLS1kZWxldGUnLCBhY3Rpb249J3N0b3JlX3RydWUnLCBoZWxwPSdEZWxldGUgRklMRXMgZnJvbSBBUkNISVZFLicpCiAgICBwYXJzZXIuYWRkX2FyZ3VtZW50KCctYScsICctLWFwcGVuZCcsIGFjdGlvbj0nc3RvcmVfdHJ1ZScsIGhlbHA9J0FwcGVuZCBGSUxFcyB0byBBUkNISVZFLicpCgogICAgcGFyc2VyLmFkZF9hcmd1bWVudCgnLTInLCAnLS10d28nLCBhY3Rpb249J3N0b3JlX3RydWUnLCBoZWxwPSdVc2UgdGhlIFJQQXYyIGZvcm1hdCBmb3IgY3JlYXRpbmcvYXBwZW5kaW5nIHRvIGFyY2hpdmVzLicpCiAgICBwYXJzZXIuYWRkX2FyZ3VtZW50KCctMycsICctLXRocmVlJywgYWN0aW9uPSdzdG9yZV90cnVlJywgaGVscD0nVXNlIHRoZSBSUEF2MyBmb3JtYXQgZm9yIGNyZWF0aW5nL2FwcGVuZGluZyB0byBhcmNoaXZlcyAoZGVmYXVsdCkuJykKCiAgICBwYXJzZXIuYWRkX2FyZ3VtZW50KCctaycsICctLWtleScsIG1ldGF2YXI9J0tFWScsIGhlbHA9J1RoZSBvYmZ1c2NhdGlvbiBrZXkgdXNlZCBmb3IgY3JlYXRpbmcgUlBBdjMgYXJjaGl2ZXMsIGluIGhleGFkZWNpbWFsIChkZWZhdWx0OiAweERFQURCRUVGKS4nKQogICAgcGFyc2VyLmFkZF9hcmd1bWVudCgnLXAnLCAnLS1wYWRkaW5nJywgbWV0YXZhcj0nQ09VTlQnLCBoZWxwPSdUaGUgbWF4aW11bSBudW1iZXIgb2YgYnl0ZXMgb2YgcGFkZGluZyB0byBhZGQgYmV0d2VlbiBmaWxlcyAoZGVmYXVsdDogMCkuJykKICAgIHBhcnNlci5hZGRfYXJndW1lbnQoJy1vJywgJy0tb3V0ZmlsZScsIGhlbHA9J0FuIGFsdGVybmF0aXZlIG91dHB1dCBhcmNoaXZlIGZpbGUgd2hlbiBhcHBlbmRpbmcgdG8gb3IgZGVsZXRpbmcgZnJvbSBhcmNoaXZlcywgb3Igb3V0cHV0IGRpcmVjdG9yeSB3aGVuIGV4dHJhY3RpbmcuJykKCiAgICBwYXJzZXIuYWRkX2FyZ3VtZW50KCctaCcsICctLWhlbHAnLCBhY3Rpb249J2hlbHAnLCBoZWxwPSdQcmludCB0aGlzIGhlbHAgYW5kIGV4aXQuJykKICAgIHBhcnNlci5hZGRfYXJndW1lbnQoJy12JywgJy0tdmVyYm9zZScsIGFjdGlvbj0nc3RvcmVfdHJ1ZScsIGhlbHA9J0JlIGEgYml0IG1vcmUgdmVyYm9zZSB3aGlsZSBwZXJmb3JtaW5nIG9wZXJhdGlvbnMuJykKICAgIHBhcnNlci5hZGRfYXJndW1lbnQoJy1WJywgJy0tdmVyc2lvbicsIGFjdGlvbj0ndmVyc2lvbicsIHZlcnNpb249J3JwYXRvb2wgdjAuOCcsIGhlbHA9J1Nob3cgdmVyc2lvbiBpbmZvcm1hdGlvbi4nKQogICAgYXJndW1lbnRzID0gcGFyc2VyLnBhcnNlX2FyZ3MoKQoKICAgICMgRGV0ZXJtaW5lIFJQQSB2ZXJzaW9uLgogICAgaWYgYXJndW1lbnRzLnR3bzoKICAgICAgICB2ZXJzaW9uID0gMgogICAgZWxzZToKICAgICAgICB2ZXJzaW9uID0gMwoKICAgICMgRGV0ZXJtaW5lIFJQQXYzIGtleS4KICAgIGlmICdrZXknIGluIGFyZ3VtZW50cyBhbmQgYXJndW1lbnRzLmtleSBpcyBub3QgTm9uZToKICAgICAgICBrZXkgPSBpbnQoYXJndW1lbnRzLmtleSwgMTYpCiAgICBlbHNlOgogICAgICAgIGtleSA9IDB4REVBREJFRUYKCiAgICAjIERldGVybWluZSBwYWRkaW5nIGJ5dGVzLgogICAgaWYgJ3BhZGRpbmcnIGluIGFyZ3VtZW50cyBhbmQgYXJndW1lbnRzLnBhZGRpbmcgaXMgbm90IE5vbmU6CiAgICAgICAgcGFkZGluZyA9IGludChhcmd1bWVudHMucGFkZGluZykKICAgIGVsc2U6CiAgICAgICAgcGFkZGluZyA9IDAKCiAgICAjIERldGVybWluZSBvdXRwdXQgZmlsZS9kaXJlY3RvcnkgYW5kIGlucHV0IGFyY2hpdmUKICAgIGlmIGFyZ3VtZW50cy5jcmVhdGU6CiAgICAgICAgYXJjaGl2ZSA9IE5vbmUKICAgICAgICBvdXRwdXQgPSBfdW5pY29kZShhcmd1bWVudHMuYXJjaGl2ZSkKICAgIGVsc2U6CiAgICAgICAgYXJjaGl2ZSA9IF91bmljb2RlKGFyZ3VtZW50cy5hcmNoaXZlKQogICAgICAgIGlmICdvdXRmaWxlJyBpbiBhcmd1bWVudHMgYW5kIGFyZ3VtZW50cy5vdXRmaWxlIGlzIG5vdCBOb25lOgogICAgICAgICAgICBvdXRwdXQgPSBfdW5pY29kZShhcmd1bWVudHMub3V0ZmlsZSkKICAgICAgICBlbHNlOgogICAgICAgICAgICAjIERlZmF1bHQgb3V0cHV0IGRpcmVjdG9yeSBmb3IgZXh0cmFj
set rpatool5=dGlvbiBpcyB0aGUgY3VycmVudCBkaXJlY3RvcnkuCiAgICAgICAgICAgIGlmIGFyZ3VtZW50cy5leHRyYWN0OgogICAgICAgICAgICAgICAgb3V0cHV0ID0gJy4nCiAgICAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICAgICBvdXRwdXQgPSBfdW5pY29kZShhcmd1bWVudHMuYXJjaGl2ZSkKCiAgICAjIE5vcm1hbGl6ZSBmaWxlcy4KICAgIGlmIGxlbihhcmd1bWVudHMuZmlsZXMpID4gMCBhbmQgaXNpbnN0YW5jZShhcmd1bWVudHMuZmlsZXNbMF0sIGxpc3QpOgogICAgICAgIGFyZ3VtZW50cy5maWxlcyA9IGFyZ3VtZW50cy5maWxlc1swXQoKICAgIHRyeToKICAgICAgICBhcmNoaXZlID0gUmVuUHlBcmNoaXZlKGFyY2hpdmUsIHBhZGxlbmd0aD1wYWRkaW5nLCBrZXk9a2V5LCB2ZXJzaW9uPXZlcnNpb24sIHZlcmJvc2U9YXJndW1lbnRzLnZlcmJvc2UpCiAgICBleGNlcHQgSU9FcnJvciBhcyBlOgogICAgICAgIHByaW50KCdDb3VsZCBub3Qgb3BlbiBhcmNoaXZlIGZpbGUgezB9IGZvciByZWFkaW5nOiB7MX0nLmZvcm1hdChhcmNoaXZlLCBlKSwgZmlsZT1zeXMuc3RkZXJyKQogICAgICAgIHN5cy5leGl0KDEpCgogICAgaWYgYXJndW1lbnRzLmNyZWF0ZSBvciBhcmd1bWVudHMuYXBwZW5kOgogICAgICAgICMgV2UgbmVlZCB0aGlzIHNlcGVyYXRlIGZ1bmN0aW9uIHRvIHJlY3Vyc2l2ZWx5IHByb2Nlc3MgZGlyZWN0b3JpZXMuCiAgICAgICAgZGVmIGFkZF9maWxlKGZpbGVuYW1lKToKICAgICAgICAgICAgIyBJZiB0aGUgYXJjaGl2ZSBwYXRoIGRpZmZlcnMgZnJvbSB0aGUgYWN0dWFsIGZpbGUgcGF0aCwgYXMgZ2l2ZW4gaW4gdGhlIGFyZ3VtZW50LAogICAgICAgICAgICAjIGV4dHJhY3QgdGhlIGFyY2hpdmUgcGF0aCBhbmQgYWN0dWFsIGZpbGUgcGF0aC4KICAgICAgICAgICAgaWYgZmlsZW5hbWUuZmluZCgnPScpICE9IC0xOgogICAgICAgICAgICAgICAgKG91dGZpbGUsIGZpbGVuYW1lKSA9IGZpbGVuYW1lLnNwbGl0KCc9JywgMikKICAgICAgICAgICAgZWxzZToKICAgICAgICAgICAgICAgIG91dGZpbGUgPSBmaWxlbmFtZQoKICAgICAgICAgICAgaWYgb3MucGF0aC5pc2RpcihmaWxlbmFtZSk6CiAgICAgICAgICAgICAgICBmb3IgZmlsZSBpbiBvcy5saXN0ZGlyKGZpbGVuYW1lKToKICAgICAgICAgICAgICAgICAgICAjIFdlIG5lZWQgdG8gZG8gdGhpcyBpbiBvcmRlciB0byBtYWludGFpbiBhIHBvc3NpYmxlIEFSQ0hJVkU9UkVBTCBtYXBwaW5nIGJldHdlZW4gZGlyZWN0b3JpZXMuCiAgICAgICAgICAgICAgICAgICAgYWRkX2ZpbGUob3V0ZmlsZSArIG9zLnNlcCArIGZpbGUgKyAnPScgKyBmaWxlbmFtZSArIG9zLnNlcCArIGZpbGUpCiAgICAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICAgICB0cnk6CiAgICAgICAgICAgICAgICAgICAgd2l0aCBvcGVuKGZpbGVuYW1lLCAncmInKSBhcyBmaWxlOgogICAgICAgICAgICAgICAgICAgICAgICBhcmNoaXZlLmFkZChvdXRmaWxlLCBmaWxlLnJlYWQoKSkKICAgICAgICAgICAgICAgIGV4Y2VwdCBFeGNlcHRpb24gYXMgZToKICAgICAgICAgICAgICAgICAgICBwcmludCgnQ291bGQgbm90IGFkZCBmaWxlIHswfSB0byBhcmNoaXZlOiB7MX0nLmZvcm1hdChmaWxlbmFtZSwgZSksIGZpbGU9c3lzLnN0ZGVycikKCiAgICAgICAgIyBJdGVyYXRlIG92ZXIgdGhlIGdpdmVuIGZpbGVzIHRvIGFkZCB0byBhcmNoaXZlLgogICAgICAgIGZvciBmaWxlbmFtZSBpbiBhcmd1bWVudHMuZmlsZXM6CiAgICAgICAgICAgIGFkZF9maWxlKF91bmljb2RlKGZpbGVuYW1lKSkKCiAgICAgICAgIyBTZXQgdmVyc2lvbiBmb3Igc2F2aW5nLCBhbmQgc2F2ZS4KICAgICAgICBhcmNoaXZlLnZlcnNpb24gPSB2ZXJzaW9uCiAgICAgICAgdHJ5OgogICAgICAgICAgICBhcmNoaXZlLnNhdmUob3V0cHV0KQogICAgICAgIGV4Y2VwdCBFeGNlcHRpb24gYXMgZToKICAgICAgICAgICAgcHJpbnQoJ0NvdWxkIG5vdCBzYXZlIGFyY2hpdmUgZmlsZTogezB9Jy5mb3JtYXQoZSksIGZpbGU9c3lzLnN0ZGVycikKICAgIGVsaWYgYXJndW1lbnRzLmRlbGV0ZToKICAgICAgICAjIEl0ZXJhdGUgb3ZlciB0aGUgZ2l2ZW4gZmlsZXMgdG8gZGVsZXRlIGZyb20gdGhlIGFyY2hpdmUuCiAgICAgICAgZm9yIGZpbGVuYW1lIGluIGFyZ3VtZW50cy5maWxlczoKICAgICAgICAgICAgdHJ5OgogICAgICAgICAgICAgICAgYXJjaGl2ZS5yZW1vdmUoZmlsZW5hbWUpCiAgICAgICAgICAgIGV4Y2VwdCBFeGNlcHRpb24gYXMgZToKICAgICAgICAgICAgICAgIHByaW50KCdDb3VsZCBub3QgZGVsZXRlIGZpbGUgezB9IGZyb20gYXJjaGl2ZTogezF9Jy5mb3JtYXQoZmlsZW5hbWUsIGUpLCBmaWxlPXN5cy5zdGRlcnIpCgogICAgICAgICMgU2V0IHZlcnNpb24gZm9yIHNhdmluZywgYW5kIHNhdmUuCiAgICAgICAgYXJjaGl2ZS52ZXJzaW9uID0gdmVyc2lvbgogICAgICAgIHRyeToKICAgICAgICAgICAgYXJjaGl2ZS5zYXZlKG91dHB1dCkKICAgICAgICBleGNlcHQgRXhjZXB0aW9uIGFzIGU6CiAgICAgICAgICAgIHByaW50KCdDb3VsZCBub3Qgc2F2ZSBhcmNoaXZlIGZpbGU6IHswfScuZm9ybWF0KGUpLCBmaWxlPXN5cy5zdGRlcnIpCiAgICBlbGlmIGFyZ3VtZW50cy5leHRyYWN0OgogICAgICAgICMgRWl0aGVyIGV4dHJhY3QgdGhlIGdpdmVuIGZpbGVzLCBvciBhbGwgZmlsZXMgaWYgbm8gZmlsZXMgYXJlIGdpdmVuLgogICAgICAgIGlmIGxlbihhcmd1bWVudHMuZmlsZXMpID4gMDoKICAgICAgICAgICAgZmlsZXMgPSBhcmd1bWVudHMuZmlsZXMKICAgICAgICBlbHNlOgogICAgICAgICAgICBmaWxlcyA9IGFyY2hpdmUubGlzdCgpCgogICAgICAgICMgQ3JlYXRlIG91dHB1dCBkaXJlY3RvcnkgaWYgbm90IHByZXNlbnQuCiAgICAgICAgaWYgbm90IG9zLnBhdGguZXhpc3RzKG91dHB1dCk6CiAgICAgICAgICAgIG9zLm1ha2VkaXJzKG91dHB1dCkKCiAgICAgICAgIyBJdGVyYXRlIG92ZXIgZmlsZXMgdG8gZXh0cmFjdC4KICAgICAgICBmb3IgZmlsZW5hbWUgaW4gZmlsZXM6CiAgICAgICAgICAgIGlmIGZpbGVuYW1lLmZpbmQoJz0nKSAhPSAtMToKICAgICAgICAgICAgICAgIChvdXRmaWxlLCBmaWxlbmFtZSkgPSBmaWxlbmFtZS5zcGxpdCgnPScsIDIpCiAgICAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICAgICBvdXRmaWxlID0gZmlsZW5hbWUKCiAgICAgICAgICAgIHRyeToKICAgICAgICAgICAgICAgIGNvbnRlbnRzID0gYXJjaGl2ZS5yZWFkKGZpbGVuYW1lKQoKICAgICAgICAgICAgICAgICMgQ3JlYXRlIG91dHB1dCBkaXJlY3RvcnkgZm9yIGZpbGUgaWYgbm90IHByZXNlbnQuCiAgICAgICAgICAgICAgICBpZiBub3Qgb3MucGF0aC5leGlzdHMob3MucGF0aC5kaXJuYW1lKG9zLnBhdGguam9pbihvdXRwdXQsIG91dGZpbGUpKSk6CiAgICAgICAgICAgICAgICAgICAgb3MubWFrZWRpcnMob3MucGF0aC5kaXJuYW1lKG9zLnBhdGguam9pbihvdXRwdXQsIG91dGZpbGUpKSkKCiAgICAgICAgICAgICAgICB3aXRoIG9wZW4ob3MucGF0aC5qb2luKG91dHB1dCwgb3V0ZmlsZSksICd3YicpIGFzIGZpbGU6CiAgICAgICAgICAgICAgICAgICAgZmlsZS53cml0ZShjb250ZW50cykKICAgICAgICAgICAgZXhjZXB0IEV4Y2VwdGlvbiBhcyBlOgogICAgICAgICAgICAgICAgcHJpbnQoJ0NvdWxkIG5vdCBleHRy
set rpatool6=YWN0IGZpbGUgezB9IGZyb20gYXJjaGl2ZTogezF9Jy5mb3JtYXQoZmlsZW5hbWUsIGUpLCBmaWxlPXN5cy5zdGRlcnIpCiAgICBlbGlmIGFyZ3VtZW50cy5saXN0OgogICAgICAgICMgUHJpbnQgdGhlIHNvcnRlZCBmaWxlIGxpc3QuCiAgICAgICAgbGlzdCA9IGFyY2hpdmUubGlzdCgpCiAgICAgICAgbGlzdC5zb3J0KCkKICAgICAgICBmb3IgZmlsZSBpbiBsaXN0OgogICAgICAgICAgICBwcmludChmaWxlKQogICAgZWxzZToKICAgICAgICBwcmludCgnTm8gb3BlcmF0aW9uIGdpdmVuIDooJykKICAgICAgICBwcmludCgnVXNlIHswfSAtLWhlbHAgZm9yIHVzYWdlIGRldGFpbHMuJy5mb3JtYXQoc3lzLmFyZ3ZbMF0pKQoK
REM --------------------------------------------------------------------------------
REM cheat.py (4864 chars max)
REM --------------------------------------------------------------------------------
set cheat1=aW1wb3J0IHJlCgp2ID0gIjEuNDEiCnRhYiA9ICIgIiAqIDQKbmV3bGluZSA9ICJcbiIKCiM9PT09PT09PT09PT09ICAuL3NjcmVlbnMucnB5ID09PT09PT09PQpkZWYgc2NyZWVucygpOgogICAgZm49InNjcmVlbnMucnB5IgogICAgd2l0aCBvcGVuKGZuLCAiciIpIGFzIGZpbGU6CiAgICAgICAgZmMgPSBmaWxlLnJlYWQoKQoKIz09PT09PT0gc2V0dGluZyBjaGVhdCB2ZXJzaW9ucyBhbmQgSGVhbCBidXR0b24KCiAgICBwYXR0PScgICAgdGV4dCAiVmVyc2lvbiAiIFwrIGNvbmZpZy52ZXJzaW9uIHhhbGlnbiAxXC4wIHlhbGlnbiAxXC4wMSBjb2xvciAiI2ZmZiIgb3V0bGluZXMgXFsgXChhYnNvbHV0ZVwoMTBcKSwgIiMwMDAiLCBhYnNvbHV0ZVwoMFwpLCBhYnNvbHV0ZVwoMFwpXCkgXF0nCiAgICByZXBsPScgICAgdGV4dCAiVmVyc2lvbiAiICsgY29uZmlnLnZlcnNpb24gKycgKyAnIiBDViAnICsgdiArICciIHhhbGlnbiAxLjAgeWFsaWduIDEuMDEgY29sb3IgIiNmZmYiIG91dGxpbmVzIFsgKGFic29sdXRlKDEwKSwgIiMwMDAiLCBhYnNvbHV0ZSgwKSwgYWJzb2x1dGUoMCkpIF0nCgogICAgZmMgPSByZS5zdWIocGF0dCwgcmVwbCwgZmMsIGZsYWdzPXJlLk0pCgogICAgcGF0dD0nICAgICAgICAgICAgdGV4dGJ1dHRvbiBfXCgiTWVudSJcKSBhY3Rpb24gU2hvd01lbnVcKFwpIHRleHRfZm9udCAiZm9udHMvcGttbmRwLnR0ZiIgYmFja2dyb3VuZCBGcmFtZVwoImd1aS9kaWFsb2d1ZV9mcmFtZS53ZWJwIlwpIGtleWJvYXJkX2ZvY3VzIEZhbHNlJwogICAgcmVwbD0nICAgICAgICAgICAgdGV4dGJ1dHRvbiBfKCJNZW51IikgYWN0aW9uIFNob3dNZW51KCkgdGV4dF9mb250ICJmb250cy9wa21uZHAudHRmIiBiYWNrZ3JvdW5kIEZyYW1lKCJndWkvZGlhbG9ndWVfZnJhbWUud2VicCIpIGtleWJvYXJkX2ZvY3VzIEZhbHNlXG4gICAgICAgICAgICB0ZXh0YnV0dG9uIF8oIkhlYWxQYXJ0eSIpIGFjdGlvbiBGdW5jdGlvbihIZWFsUGFydHkpIHRleHRfZm9udCAiZm9udHMvcGttbmRwLnR0ZiIgYmFja2dyb3VuZCBGcmFtZSgiZ3VpL2RpYWxvZ3VlX2ZyYW1lLndlYnAiKSBrZXlib2FyZF9mb2N1cyBGYWxzZVxuICAgICAgICAgICAgdGV4dGJ1dHRvbiBfKCJDaGVhdCBWJyArIHYgKyAnIikgYWN0aW9uIE51bGxBY3Rpb24oKSB0ZXh0X2ZvbnQgImZvbnRzL3BrbW5kcC50dGYiIGJhY2tncm91bmQgRnJhbWUoImd1aS9kaWFsb2d1ZV9mcmFtZS53ZWJwIikga2V5Ym9hcmRfZm9jdXMgRmFsc2UnCgogICAgZmMgPSByZS5zdWIocGF0dCwgcmVwbCwgZmMsIGZsYWdzPXJlLk0pCgojPT09PT09PSB0aW1lT2ZEYXkKICAgIHBhdHQ9JyAgICAgICAgICAgIHRleHQgIlx7c2l6ZT0oP1A8c2l6ZT5bMC05XSspXH1ce2ZvbnQ9Zm9udHMvTWljcm9ncmFtbWEtRC1PVC1Cb2xkLUV4dGVuZGVkXC50dGZcfVxbdGltZU9mRGF5XF0gLVx7L2ZvbnRcfVx7L3NpemVcfSBce3NpemU9MjhcfSJcK2dldFJXRGF5XCgwXClcKyIsICJcK3N0clwoY2FsZW5kYXIubW9udGhfbmFtZVxbY2FsRGF0ZVwubW9udGhcXVwpXCsiICJcK2dldFJEYXlcKDBcKVwrIlx7L3NpemVcfSIgY29sb3IgIig/UDxjb2xvcj4jW2EtekEtWjAtOV0rKSInCiAgICByZXBsPScgICAgICAgICAgICB0ZXh0YnV0dG9uICJ7Y29sb3I9XGc8Y29sb3I+fXtzaXplPVxnPHNpemU+fXtmb250PWZvbnRzL01pY3JvZ3JhbW1hLUQtT1QtQm9sZC1FeHRlbmRlZC50dGZ9W3RpbWVPZkRheV0gLXsvZm9udH17L3NpemV9IHtzaXplPVxnPHNpemU+fSIrZ2V0UldEYXkoMCkrIiwgIitzdHIoY2FsZW5kYXIubW9udGhfbmFtZVtjYWxEYXRlLm1vbnRoXSkrIiAiK2dldFJEYXkoMCkrInsvc2l6ZX0iIGFjdGlvbiBTZXRWYXJpYWJsZSgidGltZU9mRGF5IiwgIk1vcm5pbmciKScKICAgIGZjID0gcmUuc3ViKHBhdHQsIHJlcGwsIGZjLCBmbGFncz1yZS5NKQoKIz09PT09PT0gTW9uZXkKIyAgICAgICAgICAgIHRleHQgIiQiICsgc3RyKCd7Oix9Jy5mb3JtYXQobW9uZXkgKiAoMSBpZiBwbGF5ZXJjaGFyYWN0ZXIgPT0gTm9uZSBlbHNlIDEyKSAtICgwIGlmIG5vdCAoSGFzRXZlbnQoIkV0aGFuIiwgIlNwZW50MjAwIikgYW5kIHBsYXllcmNoYXJhY3RlciA9PSAiRXRoYW4iKSBlbHNlIDIwMCkpKSBzaXplIDI4IGNvbG9yICIjMWMxYzFjIiBhdCBUcmFuc2Zvcm0oeHpvb209LTEpIGFsdCAiIgoKICAgIHBhdHQ9JyAgICAgICAgICAgIHRleHQgIlwkIiBcKyBzdHJcKFwnXHs6LFx9XCdcLmZvcm1hdFwobW9uZXkgXCogXCgxIGlmIHBsYXllcmNoYXJhY3RlciA9PSBOb25lIGVsc2UgMTJcKSAtIFwoMCBpZiBub3QgXChIYXNFdmVudFwoIkV0aGFuIiwgIlNwZW50MjAwIlwpIGFuZCBwbGF5ZXJjaGFyYWN0ZXIgPT0gIkV0aGFuIlwpIGVsc2UgMjAwXClcKVwpIHNpemUgKD9QPHNpemU+WzAtOV0rKSBjb2xvciAiKD9QPGNvbG9yPiNbYS16QS1aMC05XSspIiBhdCBUcmFuc2Zvcm1cKHh6b29tPS0xXCknCiAgICByZXBsPScgICAgICAgICAgICB0ZXh0YnV0dG9uICJ7c2l6ZT1cZzxzaXplPn17Y29sb3I9XGc8Y29sb3I+fSQiICsgc3RyKFwnezosfVwnLmZvcm1hdChtb25leSkpIGF0IFRyYW5zZm9ybSh4em9vbT0tMSk6XG4gICAgICAgICAgICAgICAgYWN0aW9uIFNldFZhcmlhYmxlKCJtb25leSIsIG1vbmV5ICsgMzAwMDApJwogICAgZmMgPSByZS5zdWIocGF0dCwgcmVwbCwgZmMsIGZsYWdzPXJlLk0pCgojPT09PT09PSBUcmFpbmVyIEVYUHMKCiAgICBwYXR0PScgICAgICAgICAgICAgICAgYmFyIHJhbmdlIEdldEVYUFJlcXVpcmVkRm9yTGV2ZWxcKGNoYXJcKSB2YWx1ZSBwb2ludHZhbHVlIHBvcyBcKHhidWZmZXIgXCsgMTAsIDY1IFwrIHlidWZmZXJcKSB4bWF4aW11bSBtYXRoLmZsb29yXCgzMzUgXCogeHpvb212YWx1ZVwpIHJpZ2h0X2JhciAiI2ZmZiIgbGVmdF9iYXIgXChiYXJjb2xvciBpZiBwb2ludHZhbHVlID4gMCBlbHNlICIjZmZmIlwpJwogICAgcmVwbD0nICAgICAgICAgICAgICAgIGJhciB2YWx1ZSBEaWN0VmFsdWUocGVyc29uZGV4W2NoYXJdLCAiVmFsdWUiLCAxMCkgcG9zICh4YnVmZmVyICsgMTAsIDY1ICsgeWJ1ZmZlcikgeG1heGltdW0gbWF0aC5mbG9vcigzMzUgKiB4em9vbXZhbHVlKSByaWdodF9iYXIgIiNmZmYiIGxlZnRfYmFyIChiYXJjb2xvciBpZiBwb2ludHZhbHVlID4gMCBlbHNlICIjZmZmIiknCgogICAgZmMgPSByZS5zdWIocGF0dCwgcmVwbCwgZmMsIGZsYWdzPXJlLk0pCgoKIz09PT09PT0gUG9rZW1vbiBFVi9JVgogICAgcGF0dD0nICAgICAgICAgICAgdGV4dCBzdHJcKHBrbW5cLkdldCg/UDxldml2PkVWfElWKVwoU3RhdHNcLig/UDxzdGF0PkhlYWx0aHxBdHRhY2t8RGVmZW5zZXxTcGVjaWFsQXR0YWNrfFNwZWNpYWxEZWZlbnNlfFNwZWVkKVwpXCkgXCsgIi8oP1A8bnVtPjMxfDI1MikiIHhtaW5pbXVtIDMwMCB4YWxpZ24gXC41IHNpemUgNDAnCiAgICByZXBsPScgICAgICAgICAgICB0ZXh0YnV0dG9uICJ7c2l6ZT00MH0iICsgc3RyKHBrbW4uR2V0XGc8ZXZpdj4oU3RhdHMuXGc8c3RhdD4pKSArICIvKFxnPG51bT4pIiB4YWxpZ24gLjUgeXNpemUgMjAgeWFuY2hvciAtNzpcbiAgICAgICAgICAgICAgICBhY3Rpb24gU2V0RGljdChwa21uLlxnPGV2aXY+cywgU3RhdHMuXGc8c3RhdD4sIHBrbW4uR2V0XGc8ZXZpdj4oU3RhdHMuXGc8c3RhdD4pICsgMSAp
set cheat2=JwoKICAgIGZjID0gcmUuc3ViKHBhdHQsIHJlcGwsIGZjLCBmbGFncz1yZS5NKQoKIz09PT09PT0gUG9rZW1vbiBTdGF0cyBleGNsdWRlIEhlYWx0aAogCiAgICBwYXR0PScgICAgICAgICAgICB0ZXh0IHN0clwocGttbi5HZXRTdGF0XChTdGF0cy4oP1A8c3RhdD5BdHRhY2t8RGVmZW5zZXxTcGVjaWFsQXR0YWNrfFNwZWNpYWxEZWZlbnNlfFNwZWVkKSwgdHJpZ2dlckFiaWxpdGllcz1GYWxzZSwgYWJzb2x1dGU9VHJ1ZVwpXCkgeG1pbmltdW0gMzAwIHhhbGlnbiAuNSBzaXplIDQwJwogICAgcmVwbD0nICAgICAgICAgICAgdGV4dGJ1dHRvbiAie3NpemU9NDB9IiArIHN0cihwa21uLkdldFN0YXQoU3RhdHMuXGc8c3RhdD4sIHRyaWdnZXJBYmlsaXRpZXM9RmFsc2UsIGFic29sdXRlPVRydWUpKSB4YWxpZ24gLjUgeXNpemUgMjAgeWFuY2hvciAtNzpcbiAgICAgICAgICAgICAgICAgYWN0aW9uIFNldERpY3QocGttbi5TdGF0cywgU3RhdHMuXGc8c3RhdD4sIHBrbW4uR2V0U3RhdChTdGF0cy5cZzxzdGF0PikgKyAxICknCgogICAgZmMgPSByZS5zdWIocGF0dCwgcmVwbCwgZmMsIGZsYWdzPXJlLk0pCgoKIz09PT09PT0gUG9rZW1vbiBTdGF0cyBIZWFsdGgKICAgIAogICAgcGF0dD0nICAgICAgICAgICAgdGV4dCBzdHJcKG1heFwocGttbi5HZXRIZWFsdGhcKFwpLCBwa21uLkdldENhdWdodFwoXClcKVwpIFwrICIvIiBcKyBzdHJcKHBrbW4uR2V0U3RhdFwoU3RhdHMuSGVhbHRoXClcKSB4bWluaW11bSAzMDAgeGFsaWduIC41IHNpemUgNDAnCiAgICByZXBsPScgICAgICAgICAgICB0ZXh0YnV0dG9uICJ7c2l6ZT00MH0iICsgc3RyKG1heChwa21uLkdldEhlYWx0aCgpLCBwa21uLkdldENhdWdodCgpKSkgKyAiLyIgKyBzdHIocGttbi5HZXRTdGF0KFN0YXRzLkhlYWx0aCkpIHhhbGlnbiAuNSB5c2l6ZSAyMCB5YW5jaG9yIC03OlxuICAgICAgICAgICAgICAgICBhY3Rpb24gU2V0RGljdChwa21uLlN0YXRzLCBTdGF0cy5IZWFsdGgsIHBrbW4uR2V0U3RhdChTdGF0cy5IZWFsdGgpICsgMSApJwoKICAgIGZjID0gcmUuc3ViKHBhdHQsIHJlcGwsIGZjLCBmbGFncz1yZS5NKQoKCiM9PT09PT09IENsYXNzIHR5cGUKIyAgICAgICAgICAgIHRleHQgY2xhc3N0eXBlICsgIjogIiArIEZvcm1hdE51bShjbGFzc3N0YXRzW2NsYXNzdHlwZV0pIHNpemUgMzAgY29sb3IgKCIjRkZENzAwIiBpZiBjbGFzc3N0YXRzW0dldFN0YXRSYW5rKDApXSA9PSBjbGFzc3N0YXRzW2NsYXNzdHlwZV0gYW5kIGNsYXNzc3RhdHNbY2xhc3N0eXBlXSAhPSAwIGVsc2UgIiNmZmYiKSBvdXRsaW5lcyBbIChhYnNvbHV0ZSgxMCksICIjMDAwIiwgYWJzb2x1dGUoMCksIGFic29sdXRlKDApKSBdCgogICAgcGF0dD0nICAgICAgICAgICAgdGV4dCBjbGFzc3R5cGUgXCsgIjogIiBcKyBGb3JtYXROdW1cKGNsYXNzc3RhdHNcW2NsYXNzdHlwZVxdXCkgc2l6ZSAzMCBjb2xvciBcKCIjW2EtekEtWjAtOV0rIiBpZiBjbGFzc3N0YXRzXFtHZXRTdGF0UmFua1woMFwpXF0gPT0gY2xhc3NzdGF0c1xbY2xhc3N0eXBlXF0gYW5kIGNsYXNzc3RhdHNcW2NsYXNzdHlwZVxdICE9IDAgZWxzZSAiI2ZmZiJcKSBvdXRsaW5lcyBcWyBcKGFic29sdXRlXCgxMFwpLCAiIzAwMCIsIGFic29sdXRlXCgwXCksIGFic29sdXRlXCgwXClcKSBcXScKICAgIHJlcGw9JyAgICAgICAgICAgIHRleHRidXR0b24gIntzaXplPTMwfXtjb2xvcj0jZmZmfSIgKyBjbGFzc3R5cGUgKyAiOiAiICsgRm9ybWF0TnVtKGNsYXNzc3RhdHNbY2xhc3N0eXBlXSk6XG4gICAgICAgICAgICAgICBhY3Rpb24gU2V0RGljdChjbGFzc3N0YXRzLCBjbGFzc3R5cGUsIGNsYXNzc3RhdHNbY2xhc3N0eXBlXSArIDEpJwoKICAgIGZjID0gcmUuc3ViKHBhdHQsIHJlcGwsIGZjLCBmbGFncz1yZS5NKQoKCgogICAgd2l0aCBvcGVuKGZuLCAidyIpIGFzIGZpbGU6CiAgICAgICAgZmlsZS53cml0ZShmYykKCiAgICBwcmludChmIntmbn0gcGF0Y2hlZCIpCgpzY3JlZW5zKCkKCgoKCnByaW50KGYiICAgIFN1Y2Nlc3MhIENoZWF0cyBhcmUgbm93IGVuYWJsZWQhIikK
REM --------------------------------------------------------------------------------
REM !! DO NOT EDIT BELOW THIS LINE !!
REM --------------------------------------------------------------------------------
set "v=1.41"
title PALF Inject v%version%
:init
REM --------------------------------------------------------------------------------
REM Splash screen
REM --------------------------------------------------------------------------------
cls

echo  ----------------------------------------------------
echo.
echo  Pokemon Academy Life Forever Cheat Injector 
echo.             
echo   Vesrion: %v%
echo   by Sleepingkirby
echo   built on top of RL Cheat Injector by SLDR @ F95zone.com
echo  ----------------------------------------------------
echo.
echo.


REM --------------------------------------------------------------------------------
REM We need powershell for later, make sure it exists
REM --------------------------------------------------------------------------------
if not exist "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe" (
	echo    ! Error: Powershell is required, unable to continue.
	echo             This is included in Windows 7, 8, 10. XP/Vista users can
	echo             download it here: http://support.microsoft.com/kb/968929
	echo.
	pause>nul|set/p=.            Press any key to exit...
	exit
)

REM --------------------------------------------------------------------------------
REM Set our paths, and make sure we can find python exe
REM --------------------------------------------------------------------------------
set "currentdir=%~dp0%"
set "pythondir=%currentdir%..\lib\py3-windows-x86_64\"
set "renpydir=%currentdir%..\renpy\"
set "gamedir=%currentdir%"
if exist "game" if exist "lib" if exist "renpy" (
	set "pythondir=%currentdir%lib\py3-windows-x86_64\"
	set "renpydir=%currentdir%renpy\"
	set "gamedir=%currentdir%game\"
)

if not exist "%pythondir%python.exe" (
	echo    ! Error: Cannot locate python.exe, unable to continue.
	echo             Are you sure we're in the game's root directory?
	echo.
	pause>nul|set/p=.            Press any key to exit...
	exit
)

:menu
REM --------------------------------------------------------------------------------
REM Menu selection
REM --------------------------------------------------------------------------------
set exitoption=
echo   Available Options:
echo     1) Apply cheat
echo     2) Quit
echo.
set /p option=.  Enter a number: 
echo.
echo  ----------------------------------------------------
echo.
if "%option%" == "2" (
    goto quit
)

if exist "%gamedir%scripts\interface\Player_menu.rpy.orig" (
echo Backup files found. This probably means it was already patched. No need to further action. Exitting...
)

if exist "%gamedir%scripts\interface\phone.rpy.orig" (
echo Backup files found. This probably means it was already patched. No need to further action. Exitting...
)

echo Green No backup's found. Safe to progress.

REM --------------------------------------------------------------------------------
REM Write _rpatool.py from our base64 strings
REM --------------------------------------------------------------------------------
set "rpatool=%currentdir%_rpatool.py"
echo   Creating rpatool...
if exist "%rpatool%.tmp" (
	del "%rpatool%.tmp"
)
if exist "%rpatool%" (
	del "%rpatool%"
)

echo %rpatool1%>> "%rpatool%.tmp"
echo %rpatool2%>> "%rpatool%.tmp"
echo %rpatool3%>> "%rpatool%.tmp"
echo %rpatool4%>> "%rpatool%.tmp"
echo %rpatool5%>> "%rpatool%.tmp"
echo %rpatool6%>> "%rpatool%.tmp"
set "rpatoolps=%rpatool:[=`[%"
set "rpatoolps=%rpatoolps:]=`]%"
set "rpatoolps=%rpatoolps:^=^^%"
set "rpatoolps=%rpatoolps:&=^&%"
powershell.exe -nologo -noprofile -noninteractive -command "& { [IO.File]::WriteAllBytes(\"%rpatoolps%\", [Convert]::FromBase64String([IO.File]::ReadAllText(\"%rpatoolps%.tmp\"))) }"

echo.

REM --------------------------------------------------------------------------------
REM Unpack RPA
REM --------------------------------------------------------------------------------
echo   Searching for RPA packages
cd "%gamedir%"
set "PYTHONPATH=%pythondir%Lib"
for %%f in (*.rpa) do (
	echo    + Unpacking "%%~nf%%~xf" - %%~zf bytes
	"%pythondir%python.exe" -O "%rpatool%" -x "%%f"
)
echo.

REM --------------------------------------------------------------------------------
REM Clean up
REM --------------------------------------------------------------------------------
echo   Cleaning up temporary files...
REM del "%rpatool%.tmp"
REM del "%rpatool%"
echo.
if "%option%" == "2" (
	goto finish
)

:cheat
REM --------------------------------------------------------------------------------
REM Make sure cheat.py doesn't already exist
REM --------------------------------------------------------------------------------
set "cheat=%currentdir%_cheat.py"
echo   Creating cheat...
if exist "%cheat%.tmp" (
	del "%cheat%.tmp"
)
if exist "%cheat%" (
	del "%cheat%"
)

REM --------------------------------------------------------------------------------
REM Create cheat.py
REM --------------------------------------------------------------------------------
echo %cheat1%>> "%cheat%.tmp"
echo %cheat2%>> "%cheat%.tmp"
set "cheatps=%cheat:[=`[%"
set "cheatps=%cheatps:]=`]%"
set "cheatps=%cheatps:^=^^%"
set "cheatps=%cheatps:&=^&%"
powershell.exe -nologo -noprofile -noninteractive -command "& { [IO.File]::WriteAllBytes(\"%cheatps%\", [Convert]::FromBase64String([IO.File]::ReadAllText(\"%cheatps%.tmp\"))) }"

REM --------------------------------------------------------------------------------
REM Run cheat.py
REM --------------------------------------------------------------------------------
cd "%gamedir%"
"%pythondir%python.exe" -O "%cheat%"

echo.

REM --------------------------------------------------------------------------------
REM Delete temporary files
REM --------------------------------------------------------------------------------
echo   Cleaning up temporary files...
del "%cheat%.tmp"
del "%cheat%"
echo.
goto finish


:finish
REM --------------------------------------------------------------------------------
REM We are done
REM --------------------------------------------------------------------------------
echo  ----------------------------------------------------
echo.
echo    Finished!
echo.
echo    Enter "1" to go back to the menu, or any other
set /p exitoption=.   key to exit: 
echo.
echo  ----------------------------------------------------
echo.
if "%exitoption%"=="1" goto menu

:quit
exit
