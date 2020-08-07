class Nvwa < Formula
  desc "Small collection of C++ utilities"
  homepage "https://github.com/adah1972/nvwa"
  url "https://github.com/adah1972/nvwa/archive/Rel_1_0.tar.gz"
  sha256 "ee802e1e6df821c771d5b5c6b8a00138e58d50f57a2edaabcdf978eb10a09d35"

  def install
    Dir.chdir "nvwa" do
      system "#{ENV.cxx} #{ENV.cxxflags} -c *.cpp"
      system "libtool -static -o libnvwa.a *.o"
    end
    (include + name).install Dir["nvwa/*.h"]
    lib.install "nvwa/libnvwa.a"
  end
end
