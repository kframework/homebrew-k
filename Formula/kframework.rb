class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/runtimeverification/k/releases/download/v6.0.61/kframework-6.0.61-src.tar.gz"
  sha256 "64123cd0f3dbbcc59e5e424987081065efcfd664e46daecd60e1c429d485fd07"
  bottle do
    root_url "https://github.com/runtimeverification/k/releases/download/v6.0.61/"
    rebuild 567
    sha256 big_sur: "f5f60edc66362c91b483addbf876be34f97c40decb51851e4d5e57632c2f1f8e"
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
