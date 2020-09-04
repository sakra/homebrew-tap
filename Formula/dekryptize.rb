class Dekryptize < Formula
  desc "command line ncurses animation thing"
  homepage "https://github.com/mjosaarinen/dekryptize"
  head "https://github.com/mjosaarinen/dekryptize.git"

  # depends_on "cmake" => :build

  def install
    ENV.deparallelize
    system "make"
    bin.install "dekryptize"
  end

end
