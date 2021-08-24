class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "file:////Users/jenkins-slave/workspace/K_release/homebrew-k/../kframework-5.1.154-src.tar.gz"
  sha256 "e45f7679530f1324cfe0ecd6cf77dbbe9ac94fea0827e6d78a37f62e56300d88"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.1.153/"
    rebuild 49
    sha256 big_sur: "b6485a6c58828ab0dea67b92e4ecc697e132d63125b3acc79572215b08e468ad"
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
