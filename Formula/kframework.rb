class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/runtimeverification/k/releases/download/v5.3.128/kframework-5.3.128-src.tar.gz"
  sha256 "efff286ada28b6b18a79b03960271cf889b2536fd213d8c662d7f0a84ed221a8"
  bottle do
    root_url "https://github.com/runtimeverification/k/releases/download/v5.3.128/"
    rebuild 234
    sha256 cellar: :any, big_sur: "5f141cfc726561006b2634457d0ba4c956d1deb8555a11728c364a0f2c57f1ea"
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
  depends_on "llvm@13"
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
