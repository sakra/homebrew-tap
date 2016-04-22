require "formula"

class H5edit < Formula
  desc "tool for editing HDF5 files"
  homepage "http://www.hdfgroup.org/projects/jpss/h5edit_index.html"
  url "http://www.hdfgroup.org/ftp/HDF5/projects/jpss/h5edit/h5edit-1.3.1.tar.gz"
  sha1 "69a7275b2f7d4ba61f1d3c333f523d2119a78d57"

  depends_on 'hdf5'

  def install
    ENV['CC'] = "#{HOMEBREW_PREFIX}/bin/h5cc"
    ENV['CXX'] = "#{HOMEBREW_PREFIX}/bin/h5c++"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

end
