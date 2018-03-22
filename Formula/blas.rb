class Blas < Formula
  homepage 'http://www.netlib.org/blas/'
  url 'http://www.netlib.org/blas/blas.tgz'
  sha256 '55df2a24966c2928d3d2ab4a20e9856d9914b856cf4742ebd4f7a4507c8e44e8'
  version '2011-04-19'

  depends_on "gcc" => :build

  def install
    # makefiles do not work in parallel mode
    ENV.deparallelize
    inreplace "make.inc" do |s|
      s.change_make_var! 'PLAT', '_DARWIN'
    end
    system "make"
    (lib + name).install "blas_DARWIN.a" => 'libblas.a'
  end

end
