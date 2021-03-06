require 'formula'

class CloogPpl <Formula
  url 'http://www.bastoul.net/cloog/pages/download/cloog-parma-0.16.1.tar.gz'
  homepage 'http://www.bastoul.net/cloog/'
  sha1 '1c30216ca3d1e1d1feb15203f6d1b48d17faeb38'

  depends_on 'gmp'
  depends_on 'ppl'
  depends_on 'gnu-libtool' => :build

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-gmp=#{Formula.factory('gmp').prefix}",
                          "--with-ppl=#{Formula.factory('ppl').prefix}"
    # I am SO tired of the autotools mess...
    # Replace the buggy generated libtool with the Homebrew one
    File.unlink "libtool"
    File.symlink "#{HOMEBREW_PREFIX}/bin/libtool", "libtool"
    system "make"
    system "make install"
  end
end
