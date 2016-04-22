require 'formula'

class Matio < Formula
  homepage 'http://matio.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/matio/matio/1.5.0/matio-1.5.0.tar.gz'
  sha1 '70dbf09984ade6adfb38c1b62ae5585ff7f85e05'

  def options
    [
      ["--universal", "Build universal binaries."]
    ]
  end

  depends_on 'hdf5'

  def install
    ENV.universal_binary if ARGV.include? "--universal"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--with-hdf5=#{HOMEBREW_PREFIX}",
                          "--enable-mat73=yes"
    system "make check"
    system "make install"
  end

end
