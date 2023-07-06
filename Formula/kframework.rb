class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/runtimeverification/k/releases/download/v6.0.6/kframework-6.0.6-src.tar.gz"
  sha256 "dfcc3b40bb9decd2cd757058cd7bed31b15b3247789eeb1d375ac2f1c2e8b6ab"
  bottle do
    root_url "https://github.com/runtimeverification/k/releases/download/v6.0.6/"
    rebuild 526
    sha256 big_sur: "a12822daf567323ab6fee17b295147adc75c0adda1d0790d14d1c1c9fc27dc74"
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
