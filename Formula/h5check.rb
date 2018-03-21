require "formula"

class H5check < Formula
  desc "validation tool for HDF5 files"
  homepage "https://support.hdfgroup.org/products/hdf5_tools/h5check.html"
  url "https://support.hdfgroup.org/ftp/HDF5/tools/h5check/src/h5check-2.0.1.tar.gz"
  sha256 "72a6c2d19dea09962af0ac97277293b58d2119ea9f04fbfa6a2a7dc89734a7be"

  depends_on 'hdf5'

  def install
    ENV['CC'] = "#{HOMEBREW_PREFIX}/bin/h5cc"
    ENV['CXX'] = "#{HOMEBREW_PREFIX}/bin/h5c++"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

end
