class Hdfql < Formula
  desc "Hierarchical Data Format query language"
  homepage "http://www.hdfql.com"
  url "http://www.hdfql.com/releases/2.2.0/HDFql-2.2.0_Darwin64_GCC-4.9.zip"
  version "2.2.0"
  sha256 "780bc85484101a28d48b6498692e6ccfaf653eb9135246afce23ade69111a8cb"

  depends_on "gcc@4.9"

  def install
    cd "bin" do
      macho = MachO.open("HDFqlCLI")
      macho.change_dylib("/opt/local/lib/libgcc/libgcc_s.1.dylib",
                         "#{HOMEBREW_PREFIX}/lib/gcc/4.9/libgcc_s.1.dylib")
      macho.write!
      bin.install Dir["*"]
    end
    cd "doc" do
      doc.install Dir["*"]
    end
    cd "include" do
      include.install Dir["*"]
    end
    cd "lib" do
      macho = MachO.open("libHDFql.dylib")
      macho.change_dylib("/opt/local/lib/libgcc/libgcc_s.1.dylib",
                         "#{HOMEBREW_PREFIX}/lib/gcc/4.9/libgcc_s.1.dylib")
      macho.change_dylib("/opt/local/lib/libgcc/libgomp.1.dylib",
                         "#{HOMEBREW_PREFIX}/lib/gcc/4.9/libgomp.dylib")
      macho.write!
      lib.install Dir["*"]
    end
  end
end
