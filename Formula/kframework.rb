class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "file:////Users/jenkins-slave/workspace/K_release/homebrew-k/../kframework-5.1.128-src.tar.gz"
  sha256 "02fef2e6c420f4746ce467a8490ba2669489b0cdb470a637339a76e629e14055"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.1.127/"
    rebuild 36
    sha256 cellar: :any, big_sur: "311f8c343052ca18f322d9b3093a7be2722b3b4886dc6e5ad95af7c4c3b0abc3"
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
  depends_on "llvm@8"
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
