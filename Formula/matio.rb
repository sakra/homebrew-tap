require 'formula'

class Matio < Formula
  homepage 'https://matio.sourceforge.io/'
  url 'https://downloads.sourceforge.net/project/matio/matio/1.5.12/matio-1.5.12.7z'
  sha256 '7228c9b976b932ff19fb3ed57ad0a87a926617734bd117f939f2de3f9cd2e7b0'

  depends_on 'hdf5'

  def install
    cd "matio-1.5.12" do
      system "bash", "configure", "--disable-debug", "--disable-dependency-tracking",
                            "--prefix=#{prefix}", "--with-hdf5=#{HOMEBREW_PREFIX}",
                            "--enable-mat73=yes"
      system "make check"
      system "make install"
    end
  end

end
