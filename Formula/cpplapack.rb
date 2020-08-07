class Cpplapack < Formula
  desc "C++ class wrapper for BLAS, LAPACK and PARDISO"
  homepage "https://cpplapack.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/cpplapack/cpplapack-2015.05.11/cpplapack-2015.05.11-1.tar.gz"
  version "2015.05.11"
  sha256 "5e53dfde7c399caf0fa96b41d22039e9000513c12bba3ba09dc7d96225902172"

  def install
    # put all includes into a directory of their own
    (include + "cpplapack").install Dir["include/*"]
  end
end
