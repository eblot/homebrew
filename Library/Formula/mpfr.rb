require 'formula'

class Mpfr < Formula
  url 'http://www.mpfr.org/mpfr-3.0.1/mpfr-3.0.1.tar.bz2'
  homepage 'http://www.mpfr.org/'
  md5 'bfbecb2eacb6d48432ead5cfc3f7390a'

  depends_on 'gmp'

  def options
    [["--32-bit", "Force 32-bit."]]
  end

  def install
    if Hardware.is_32_bit? or ARGV.include? "--32-bit"
      ENV.m32
      args << "--host=none-apple-darwin"
    else
      ENV.m64
    end

    system "./configure", "--disable-dependency-tracking", 
                          "--prefix=#{prefix}",
                          "--with-gmp=#{Formula.factory('gmp').prefix}"
    system "make install"
  end
end
