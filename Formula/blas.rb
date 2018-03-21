class Blas < Formula
  homepage 'http://www.netlib.org/blas/'
  url 'http://www.netlib.org/blas/blas.tgz'
  sha256 'ef7d775d380f255d1902bce374ff7c8a594846454fcaeae552292168af1aca24'
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
