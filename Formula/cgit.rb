require 'formula'

class Cgit < Formula
  homepage 'https://git.zx2c4.com/cgit'
  url 'https://git.zx2c4.com/cgit/snapshot/cgit-1.1.tar.xz'
  sha256 '0889af29be15fc981481caa09579f982b9740fe9fd2860ab87dff286f4635890'

  depends_on 'gettext'
  depends_on 'openssl'
  depends_on 'libzip'
  depends_on 'lua'

  def install
    ENV.append 'CFLAGS', "-I#{Formula["gettext"].opt_include}"
    ENV.append 'LDFLAGS', "-L#{Formula["gettext"].opt_lib}"
    ENV.append 'CFLAGS', "-I#{Formula["openssl"].opt_include}"
    ENV.append 'LDFLAGS', "-L#{Formula["openssl"].opt_lib}"
    inreplace "Makefile" do |s|
      s.change_make_var! "prefix", prefix
      s.change_make_var! "CGIT_CONFIG", "#{etc}/cgitrc"
      s.change_make_var! "CACHE_ROOT", "#{var}/cache/cgit"
      s.change_make_var! "CGIT_SCRIPT_NAME", "cgit.cgi"
      s.change_make_var! "CGIT_SCRIPT_PATH", "#{prefix}/cgi"
      s.change_make_var! "filterdir", "#{prefix}/filters"
    end
    inreplace "cgitrc.5.txt" do |s|
      s.gsub! "/etc", etc
      s.gsub! "/var", var
    end
    inreplace "README" do |s|
      s.gsub! "/etc", etc
      s.gsub! "/var/www/htdocs/cgit", " #{opt_prefix}/cgi"
    end
    system "make get-git"
    system "make"
    system "make install"
  end

  def caveats; <<~EOS
    The cgit CGI executable is #{opt_prefix}/cgi/cgit.cgi

    The default runtime configuration file is #{etc}/cgitrc
    EOS
  end

end
