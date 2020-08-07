class Vectorclass < Formula
  desc "C++ vector class library"
  homepage "http://www.agner.org/optimize/#vectorclass"
  url "https://github.com/vectorclass/version2/archive/v2.01.00.tar.gz"
  sha256 "d6e31e0ef619647f1a497a75c9c11c42c4bfb0536f104bc5757d9ca08a7da38e"

  depends_on "libtool" => :build

  def install
    chmod_R 0644, Dir["*.h"]
    system ENV.cxx, "-std=c++14", "-c", "instrset_detect.cpp", "-o", "instrset_detect.o"
    system "libtool", "-static", "-o", "libvectorclass.a", "instrset_detect.o"
    (lib + name).install "libvectorclass.a"
    (include + name).install Dir["*.h"]
  end
end
