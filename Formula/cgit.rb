require 'formula'

class CgitGit < Formula
  homepage 'http://git.zx2c4.com/cgit/'
  url 'http://git.plenz.com/git/snapshot/git-1.7.3.5.tar.gz'
  sha1 '6e556483ff409241edd793cf79d9052e1f8f1c57'
end

class Cgit < Formula
  homepage 'http://git.zx2c4.com/cgit/'
  url 'http://git.zx2c4.com/cgit/snapshot/cgit-0.9.0.3.zip'
  sha1 '744903be9985c1fceefdb221795d945fdb6c6d4d'

  def patches
    # Fix libiconv dependency on Darwin
    # Prevent missing file errors upon making dependencies
    # Prevent xmllint errors upon "make install-doc"
    DATA
  end

  def options
    [['--build-docs', "Build man pages and HTML docu using asciidoc"]]
  end

  if ARGV.include? '--build-docs'
    # these are needed to build man pages
    depends_on 'asciidoc'
  end

  def install
    # cgit needs the expanded git tarball in its source directory
    # we do not use "make get-git" target, which does not use Homebrew download cache
    d = Dir.getwd
    CgitGit.new.brew do
      Dir['*'].each do |file|
        mv file, "#{d}/git"
      end
    end
    inreplace "Makefile" do |s|
      s.change_make_var! "prefix", "#{prefix}"
      s.change_make_var! "CGIT_CONFIG", "#{etc}/cgitrc"
      s.change_make_var! "CACHE_ROOT", "#{var}/cache/cgit"
      s.change_make_var! "CGIT_SCRIPT_NAME", "cgit.cgi"
      s.change_make_var! "CGIT_SCRIPT_PATH", "#{prefix}/share/cgit"
      s.change_make_var! "GIT_OPTIONS", "prefix=#{prefix}"
      s.change_make_var! "filterdir", "#{prefix}/filters"
    end
    inreplace %w(cgitrc.5.txt README) do |s|
      s.gsub! "/etc", "#{etc}"
      s.gsub! "/var/www/htdocs/cgit", "#{prefix}/share/cgit"
      s.gsub! "/var", "#{var}"
    end
#    system "make get-git"
    system "make"
    system "make install"
    if ARGV.include? '--build-docs'
      system "make install-man"
      system "make install-html"
      # do not build pdf docu which depends on dblatex
    end
  end

  def caveats; <<-EOS.undent
    The cgit CGI executable is #{prefix}/share/cgit/cgit.cgi

    The default runtime configuration file is #{etc}/cgitrc
    EOS
  end

end

__END__
diff --git a/Makefile b/Makefile
index 6de072a..078c1d4 100644
--- a/Makefile
+++ b/Makefile
@@ -88,7 +88,7 @@ endif
 	$(QUIET_CC)$(CC) -o $*.o -c $(CFLAGS) $<


-EXTLIBS = git/libgit.a git/xdiff/lib.a -lz -lpthread
+EXTLIBS = git/libgit.a git/xdiff/lib.a -lz -lpthread -liconv
 OBJECTS =
 OBJECTS += cache.o
 OBJECTS += cgit.o
@@ -163,7 +163,7 @@ cgit: $(OBJECTS) libgit

 cgit.o: VERSION

-ifneq "$(MAKECMDGOALS)" "clean"
+ifneq "$(MAKECMDGOALS)" "get-git"
   -include $(OBJECTS:.o=.d)
 endif

@@ -226,13 +226,13 @@ doc-html: $(DOC_HTML)
 doc-pdf: $(DOC_PDF)

 %.5 : %.5.txt
-	a2x -f manpage $<
+	a2x -L -f manpage $<

 $(DOC_HTML): %.html : %.txt
-	a2x -f xhtml --stylesheet=cgit-doc.css $<
+	a2x -L -f xhtml --stylesheet=cgit-doc.css $<

 $(DOC_PDF): %.pdf : %.txt
-	a2x -f pdf cgitrc.5.txt
+	a2x -L -f pdf cgitrc.5.txt

 clean: clean-doc
 	rm -f cgit VERSION *.o *.d
