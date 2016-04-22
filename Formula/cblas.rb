require 'formula'

class Cblas <Formula
  url 'http://www.netlib.org/blas/blast-forum/cblas.tgz'
  homepage 'http://www.netlib.org/blas/'
  version '2011-01-20'
  sha1 'd6970cf52592ef67674a61c78bbd055a4e9d4680'

  depends_on :fortran
  depends_on 'clapack' => :build

  def options
    [
      ["--universal", "Build universal binaries."]
    ]
  end

  def install
    # makefiles do not work in parallel mode
    ENV.deparallelize
    ENV.universal_binary if ARGV.include? "--universal"
    ENV.append 'CFLAGS', "-DADD_"
    cp 'Makefile.LINUX', 'Makefile.in'
    inreplace "Makefile.in" do |s|
      s.change_make_var! 'PLAT', 'DARWIN'
      s.change_make_var! "CC", ENV['CC']
      s.change_make_var! 'CFLAGS', ENV['CFLAGS']
      s.change_make_var! 'BLLIB', '/usr/local/lib/clapack/libblas.a /usr/local/lib/clapack/libf2c.a'
    end
    system "make"
    # fix permissions for installation
    chmod_R 0644, Dir['**/*.h']
    (include + name).install Dir['include/*.h']
    (lib + name).install "lib/cblas_DARWIN.a" => 'libcblas.a'
  end
end
