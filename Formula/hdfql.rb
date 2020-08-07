class Hdfql < Formula
  desc "Hierarchical Data Format query language"
  homepage "http://www.hdfql.com"
  url "http://www.hdfql.com/releases/1.5.0/HDFql-1.5.0_Darwin64_GCC-4.9.zip"
  version "1.5.0"
  sha256 "71ddee86b36c8162cd1cb23bfbbb17d0174b3fa7b4b8dcd8f986ff70df515b60"

  depends_on "gcc@4.9"

  def install
    cd "lib" do
      system "install_name_tool -change /opt/local/lib/libgcc/libgcc_s.1.dylib #{HOMEBREW_PREFIX}/lib/gcc/4.9/libgcc_s.1.dylib libHDFql.dylib"
      system "install_name_tool -change /opt/local/lib/libgcc/libgomp.1.dylib #{HOMEBREW_PREFIX}/lib/gcc/4.9/libgomp.dylib libHDFql.dylib"
      lib.install "libHDFql.dylib"
    end
    cd "bin" do
      system "install_name_tool -change /opt/local/lib/libgcc/libgcc_s.1.dylib #{HOMEBREW_PREFIX}/lib/gcc/4.9/libgcc_s.1.dylib HDFqlCLI"
      system "install_name_tool -change ../lib/64/GCC-4.9/libHDFql.dylib #{lib}/libHDFql.dylib HDFqlCLI"
      bin.install "HDFqlCLI"
    end
    doc.install "doc/HDFqlReferenceManual.pdf"
  end
end
