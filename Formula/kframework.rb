class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.2.62/kframework-5.2.62-src.tar.gz"
  sha256 "2f08efb712fdfadcabbba0e38f4c0238e9ca7fd251ddb85f3ce7b576ae1991c1"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.2.62/"
    rebuild 119
    sha256 cellar: :any, big_sur: "ba0ad94f920a96617acfe946cb4eb6a196b2d478745de201b90d7f92ebab0679"
  end
  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "haskell-stack" => :build
  depends_on "maven" => :build
  depends_on "pkg-config" => :build
  depends_on "bison"
  depends_on "flex"
  depends_on "gmp"
  depends_on "jemalloc"
  depends_on "libyaml"
  depends_on "llvm@12"
  depends_on "mpfr"
  depends_on "openjdk"
  depends_on "z3"

  def install
    ENV["SDKROOT"] = MacOS.sdk_path
    ENV["DESTDIR"] = ""
    ENV["PREFIX"] = prefix.to_s
    ENV["HOMEBREW_PREFIX"] = HOMEBREW_PREFIX

    # Unset MAKEFLAGS for `stack setup`.
    # Prevents `install: mkdir ... ghc-7.10.3/lib: File exists`
    # See also: https://github.com/brewsci/homebrew-science/blob/bb52ecc66b6f9fad4d281342139189ae81d7c410/Formula/tamarin-prover.rb#L27
    ENV.deparallelize do
      cd "haskell-backend/src/main/native/haskell-backend" do
        system "stack", "setup"
      end
    end

    system "mvn", "package", "-DskipTests", "-Dproject.build.type=FastBuild"
    system "package/package"
  end

  test do
    system "true"
  end
end
