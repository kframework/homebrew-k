class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/runtimeverification/k/releases/download/v5.5.95/kframework-5.5.95-src.tar.gz"
  sha256 "76eae4952ee3eabadd29bad56d15bab06a81e64ee2f2238465dd7aa1c38b480f"
  bottle do
    root_url "https://github.com/runtimeverification/k/releases/download/v5.5.95/"
    rebuild 380
    sha256 cellar: :any, big_sur: "faf31efd3e5984cc8bfa3b5d74c4caac09cb8bcc60c5bdfe7f13b1d89a617a06"
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
        original_path = ENV["PATH"]
        ENV["PATH"] = ENV["PATH"].sub "#{Formula["llvm@13"].bin}:", ""
        system "stack", "setup"
        ENV["PATH"] = original_path
      end
    end

    system "mvn", "package", "-DskipTests", "-Dproject.build.type=FastBuild"
    system "package/package"
  end

  test do
    system "true"
  end
end
