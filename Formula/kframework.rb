class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/runtimeverification/k/releases/download/v5.6.94/kframework-5.6.94-src.tar.gz"
  sha256 "82b3864763f1e088944dbef992fa66cb15ac4c67aeb8300712fe817e2ec5859d"
  bottle do
    root_url "https://github.com/runtimeverification/k/releases/download/v5.6.94/"
    rebuild 485
    sha256 big_sur: "aa05a48c85a5a02b2b2cdccc5338c82ce6cdafc2c13eba316c62acfdd7d1becb"
  end
  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "haskell-stack" => :build
  depends_on "maven" => :build
  depends_on "pkg-config" => :build
  depends_on "bison"
  depends_on "flex"
  depends_on "fmt"
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
        # This is a hack to get LLVM off the PATH when building:
        # https://github.com/Homebrew/homebrew-core/issues/122863
        with_env(PATH: ENV["PATH"].sub("#{Formula["llvm@13"].bin}:", "")) do
          system "stack", "setup"
        end

        # Build the Haskell backend before running maven so that our connections
        # don't time out.
        system "stack", "build"
      end
    end

    system "mvn", "package", "-DskipTests", "-Dproject.build.type=FastBuild", "-Dmaven.wagon.httpconnectionManager.ttlSeconds=30"
    system "package/package"
  end

  test do
    system "true"
  end
end
