require 'formula'

class Matio < Formula
  homepage 'http://matio.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/matio/matio/1.5.0/matio-1.5.0.tar.gz'
  sha256 '550dfa642c4ca7ad5ce5a0249264436ced14c72c116aee9fd14e99c7bd8cc72e'

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
