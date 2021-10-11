class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.1.225/kframework-5.1.225-src.tar.gz"
  sha256 "585ed5ddfcde64a55d040f9e8975de6d80ef1e26e47c328847b5bf03c789c792"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.1.225/"
    rebuild 83
    sha256 big_sur: "1dec3653b05147d2568aab8ef78e212a32746091bcba87d3094dc159c1e27b77"
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
  depends_on "z3"

  def install
    ENV["SDKROOT"] = MacOS.sdk_path
    ENV["DESTDIR"] = ""
    ENV["PREFIX"] = prefix.to_s

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
