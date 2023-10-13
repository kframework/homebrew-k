class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/runtimeverification/k/releases/download/v6.0.139/kframework-6.0.139-src.tar.gz"
  sha256 "56688e5d2baebd051898f62fef73e6f6ccfa05dc66c55e1f0d13a23d176faf7c"
  bottle do
    root_url "https://github.com/runtimeverification/k/releases/download/v6.0.139/"
    rebuild 611
    sha256 ventura: "6ce3bb896d8a073d5024b1c5d9867e1cca0b20ebe2d0b5a2c6ea7737cf610ddf"
  end
  depends_on "cmake" => :build
  depends_on "haskell-stack" => :build
  depends_on "maven" => :build
  depends_on "pkg-config" => :build
  depends_on "bison"
  depends_on "boost"
  depends_on "flex"
  depends_on "fmt"
  depends_on "gmp"
  depends_on "jemalloc"
  depends_on "libyaml"
  depends_on "llvm@13"
  depends_on "mpfr"
  depends_on "openjdk"
  depends_on "secp256k1"
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
        # This is a hack to get LLVM off the PATH when building:
        # https://github.com/Homebrew/homebrew-core/issues/122863
        with_env(PATH: ENV["PATH"].sub("#{Formula["llvm@13"].bin}:", "")) do

        # For both components, we need to run the stack phases _outside_ of
        # Maven to prevent connections from timing out.
        cd "haskell-backend/src/main/native/haskell-backend" do
          system "stack", "setup"
          system "stack", "build"
        end

        cd "hs-backend-booster/src/main/native/hs-backend-booster" do
          system "stack", "setup"
          system "stack", "build"
        end
      end
    end

    system "mvn", "package", "-DskipTests", "-Dproject.build.type=FastBuild", "-Dmaven.wagon.httpconnectionManager.ttlSeconds=30"
    system "package/package"
  end

  test do
    system "true"
  end
end
