require 'formula'

class Atlas <Formula
  url 'http://sourceforge.net/projects/math-atlas/files/Stable/3.10.0/atlas3.10.0.tar.bz2'
  homepage 'http://math-atlas.sourceforge.net/'
  sha256 'a90a2e3463504e3297b56edc13769d766732e82bd8f1de951cfc78444f148465'

  def patches
    # Makefile does not handle missing Fortran compiler correctly
    DATA
  end

  def options
    [
      ["--universal", "Build universal binaries."]
    ]
  end

  def install
    ENV.deparallelize
    ENV.universal_binary if ARGV.include? "--universal"
    mkdir "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}", "--nof77",
             "--cc=#{ENV.cc}", "--cflags=#{ENV.cflags}"
      system "make"
      system "make install"
    end
  end
end

__END__
