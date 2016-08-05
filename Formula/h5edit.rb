require "formula"

class H5edit < Formula
  desc "tool for editing HDF5 files"
  homepage "http://www.hdfgroup.org/projects/jpss/h5edit_index.html"
  url "http://www.hdfgroup.org/ftp/HDF5/projects/jpss/h5edit/h5edit-1.3.1.tar.gz"
  sha256 "57e2cc7cd67af82614e51064ee969ffa0a5328b8c58c4ed7085db32a8d99acef"

  depends_on 'hdf5'

  def install
    ENV['CC'] = "#{HOMEBREW_PREFIX}/bin/h5cc"
    ENV['CXX'] = "#{HOMEBREW_PREFIX}/bin/h5c++"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

end
