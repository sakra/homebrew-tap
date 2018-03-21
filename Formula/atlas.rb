class Atlas < Formula
  url 'https://downloads.sourceforge.net/projects/math-atlas/files/Stable/3.10.0/atlas3.10.0.tar.bz2'
  homepage 'https://math-atlas.sourceforge.io/'
  sha256 'a90a2e3463504e3297b56edc13769d766732e82bd8f1de951cfc78444f148465'

  def install
    ENV.deparallelize
    mkdir "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}", "--nof77",
             "--cc=#{ENV.cc}", "--cflags=#{ENV.cflags}"
      system "make"
      system "make install"
    end
  end
end
