class Matio < Formula
  desc "C library for reading and writing MATLAB MAT files"
  homepage "https://matio.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/matio/matio/1.5.12/matio-1.5.12.tar.gz"
  sha256 "8695e380e465056afa5b5e20128935afe7d50e03830f9f7778a72e1e1894d8a9"

  depends_on "hdf5"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--with-hdf5=#{HOMEBREW_PREFIX}",
                          "--enable-mat73=yes"
    system "make install"
  end
end
