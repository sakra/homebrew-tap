require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Blas < Formula
  homepage 'http://www.netlib.org/blas/'
  url 'http://www.netlib.org/blas/blas.tgz'
  sha1 'a643b737c30a0a5b823e11e33c9d46a605122c61'
  version '2011-04-19'

  depends_on 'gfortran' => :build

  def options
    [
      ["--universal", "Build universal binaries."]
    ]
  end

  def install
    # makefiles do not work in parallel mode
    ENV.deparallelize
    ENV.universal_binary if ARGV.include? "--universal"
    inreplace "make.inc" do |s|
      s.change_make_var! 'PLAT', '_DARWIN'
    end
    system "make"
    (lib + name).install "blas_DARWIN.a" => 'libblas.a'
  end

end
