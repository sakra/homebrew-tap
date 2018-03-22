class Vectorclass < Formula
  desc "C++ vector class library"
  homepage "http://www.agner.org/optimize/#vectorclass"
  url "http://www.agner.org/optimize/vectorclass.zip"
  version "2017-Jul-27"
  sha256 "f9cb70a3e865dd019b58f449d11f90147ce8ba5f2c60410389ec0ead92944b97"

  depends_on "libtool" => :build

  def install
    system "unzip", "special.zip"
    chmod_R 0644, Dir['*.h']
    system ENV.cxx, "-c", "ranvec1.cpp", "-o", "ranvec1.o"
    system ENV.cxx, "-c", "instrset_detect.cpp", "-o", "instrset_detect.o"
    system "libtool", "-static", "-o", "libvectorclass.a", "instrset_detect.o", "ranvec1.o"
    (lib + name).install "libvectorclass.a"
    (include + name).install Dir['*.h']
    doc.install 'vectorclass.pdf'
  end

end
