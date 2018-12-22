class Eastl < Formula
  desc "Electronic Arts Standard Template Library"
  homepage "https://github.com/electronicarts/EASTL"
  url "https://github.com/electronicarts/EASTL/archive/3.12.04.tar.gz"
  sha256 "320aacde350bac832756e300d4ae738a8b20148e52118e18131e673f4bbe9d22"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

end
