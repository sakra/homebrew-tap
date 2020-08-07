class Macstl < Formula
  desc "C++ header library for SIMD"
  homepage "http://www.pixelglow.com/macstl/"
  url "http://www.pixelglow.com/downloads/macstl-0.3.1.tgz"
  sha256 "c423384aa6430c7c36ad81a53b5f66b46f5c8e596a0e62216dfc8edf4bf64125"

  def install
    include.install "macstl"
  end
end
