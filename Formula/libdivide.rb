require 'formula'

class Libdivide <Formula
  head 'http://svn.libdivide.com/libdivide/trunk/', :using => :svn
  homepage 'http://libdivide.com/'

  def install
    inreplace "Makefile" do |s|
      s.change_make_var! 'CC', ENV['CC']
      s.change_make_var! 'CPP', ENV['CXX']
      s.change_make_var! 'LINKFLAGS', ENV['LDFLAGS']
    end
    system "make release"
    system "make benchmark"
    include.install "libdivide.h"
    bin.install "tester" => "libdivide_tester"
    bin.install "benchmark" => "libdivide_benchmark"
  end
end
