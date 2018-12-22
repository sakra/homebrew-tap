require 'formula'

class Sshpass < Formula
  url 'https://sourceforge.net/projects/sshpass/files/sshpass/1.06/sshpass-1.06.tar.gz/download'
  homepage 'https://sshpass.sourceforge.io/'
  sha256 'c6324fcee608b99a58f9870157dfa754837f8c48be3df0f5e2f3accf145dee60'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
