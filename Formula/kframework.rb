class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/runtimeverification/k/releases/download/v5.5.97/kframework-5.5.97-src.tar.gz"
  sha256 "9c7009ebaf1c791f854c9d3bfc6a7d8fd2a9d21ad071d2657f9dec3f7e5177e3"
  bottle do
    root_url "https://github.com/runtimeverification/k/releases/download/v5.5.97/"
    rebuild 382
    sha256 cellar: :any, big_sur: "97251fcb47e08403ccea071c8f2f3418b4966401cb8f18840bc337e0f1dbd2b6"
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
      end
    end

    system "mvn", "package", "-DskipTests", "-Dproject.build.type=FastBuild"
    system "package/package"
  end

  test do
    system "true"
  end
end
