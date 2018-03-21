require 'formula'

class Nvwa <Formula
  url 'http://sourceforge.net/projects/nvwa/files/nvwa/1.0/nvwa-1.0.tar.gz'
  homepage 'http://nvwa.sourceforge.net/'
  sha256 '5b2b5963ced715011c269291041b80c6edfd42188f582a0cf294cdff4b94f605'

  def install
    Dir.chdir "nvwa" do
      system "#{ENV.cxx} #{ENV.cxxflags} -c *.cpp"
      system "libtool -static -o libnvwa.a *.o"
    end
    (include + name).install Dir['nvwa/*.h']
    lib.install "nvwa/libnvwa.a"
  end
end
