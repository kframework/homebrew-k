class Kalgorand < Formula
  desc "Algorand K semantics"
  homepage "https://www.github.com/runtimeverification/algorand-sc-semantics"
  license "NCSA"
  head "git@github.com:runtimeverification/algorand-sc-semantics.git",
    using: :git, branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "ccache" => :build
  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "openssl" => :build
  depends_on "pkg-config" => :build
  depends_on "z3" => :build

  depends_on "kframework/k/cryptopp@8.6.0"
  depends_on "kframework/k/kframework"

  depends_on "boost"
  depends_on "jq"
  depends_on "libbitcoin"
  depends_on "libsodium"
  depends_on "msgpack-cxx"
  depends_on "python3"
  depends_on "shellcheck"
  depends_on "sqlite3"

  def install
    ENV["BITCOIN_LIBEXEC"] = Formula["libbitcoin"].libexec
    ENV["SSL_ROOT"] = Formula["openssl"].prefix

    system "make", "build"

    system "make", "install", "DESTDIR=install"

    prefix.install "install/usr/lib"
    prefix.install "install/usr/bin"
  end

  test do
    (testpath/"test.teal").write <<~HERE
      #pragma version 3
      #pragma mode stateless
      byte "\x01\x02\x03"
      int 4
      getbyte
    HERE

    system bin/"kalgo", "parse", "--backend", "teal", "test.teal"
  end
end
