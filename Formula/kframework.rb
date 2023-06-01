class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/runtimeverification/k/releases/download/v5.6.117/kframework-5.6.117-src.tar.gz"
  sha256 "0caf747148a3dfb375973d3a568562f919b45f8bfb17be46e54249e0d2f8b75c"
  bottle do
    root_url "https://github.com/runtimeverification/k/releases/download/v5.6.117/"
    rebuild 502
    sha256 big_sur: "bb597ed6698c4bb4a95f4562b749e45f0ed30349d05226593928a9b0199b893e"
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
