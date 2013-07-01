require 'formula'

def postgres_installed?
  `which pg_config`.length > 0
end

def build_intl?
  false
end

class AbstractPhp < Formula
  def initialize name='__UNKNOWN__', path=nil
    begin
      raise "One does not simply install an AbstractPhp formula" if name == "abstract-php"
      super
    rescue Exception => e
      # Hack so that we pass all brew doctor tests
      reraise = e.backtrace.select { |l| l.match(/(doctor|cleanup|leaves|uses)\.rb/) }
      raise e if reraise.empty?
    end
  end

  def self.init
    homepage 'http://php.net'

    # So PHP extensions don't report missing symbols
    skip_clean ['bin', 'sbin']

    depends_on 'curl' unless MacOS.version >= :lion
    depends_on 'freetds' if build.include? 'with-mssql'
    depends_on 'freetype'
    depends_on 'gettext'
    depends_on 'gmp' => :optional
    depends_on 'icu4c' if build.include?('with-intl') && build_intl?
    depends_on 'imap-uw' if build.include? 'with-imap'
    depends_on 'jpeg'
    depends_on 'libpng'
    depends_on 'libxml2' unless MacOS.version >= :lion
    depends_on 'openssl' if build.include? 'with-homebrew-openssl'
    depends_on 'homebrew/dupes/tidy' if build.include? 'with-tidy'
    depends_on 'unixodbc'
    depends_on 'homebrew/dupes/zlib'

    # Sanity Checks
    if build.include? 'with-pgsql'
      depends_on 'postgresql' => :recommended unless postgres_installed?
    end

    if build.include?('with-cgi') && build.include?('with-fpm')
      raise "Cannot specify more than one executable to build."
    end

    option '32-bit', "Build 32-bit only."
    option 'homebrew-apxs', 'Build against apxs in Homebrew prefix'
    option 'with-debug', 'Compile with debugging symbols'
    option 'with-libmysql', 'Include (old-style) libmysql support'
    option 'without-mysql', 'Remove MySQL/MariaDB support'
    option 'with-pgsql', 'Include PostgreSQL support'
    option 'with-mssql', 'Include MSSQL-DB support'
    option 'with-cgi', 'Enable building of the CGI executable (implies --without-apache)'
    option 'with-fpm', 'Enable building of the fpm SAPI executable (implies --without-apache)'
    option 'without-apache', 'Build without shared Apache 2.0 Handler module'
    option 'with-intl', 'Include internationalization support'
    option 'with-imap', 'Include IMAP extension'
    option 'without-pear', 'Build without PEAR'
    option 'with-tidy', 'Include Tidy support'
    option 'with-thread-safety', 'Build with thread safety'
    option 'with-homebrew-openssl', 'Include OpenSSL support via Homebrew'
    option 'without-bz2', 'Build without bz2 support'
    option 'without-pcntl', 'Build without Process Control support'
  end

  def config_path
    etc+"php/"+php_version.to_s
  end

  def home_path
    File.expand_path("~")
  end

  def build_apache?
    !(build.include?('without-apache') || build.include?('with-cgi') || build.include?('with-fpm'))
  end

  def php_version
    raise "Unspecified php version"
  end

  def php_version_path
    raise "Unspecified php version path"
  end

  def install
    # Ensure this php has a version specified
    php_version
    php_version_path

    # Not removing all pear.conf and .pearrc files from PHP path results in
    # the PHP configure not properly setting the pear binary to be installed
    config_pear = "#{config_path}/pear.conf"
    user_pear = "#{home_path}/pear.conf"
    config_pearrc = "#{config_path}/.pearrc"
    user_pearrc = "#{home_path}/.pearrc"
    if File.exists?(config_pear) || File.exists?(user_pear) || File.exists?(config_pearrc) || File.exists?(user_pearrc)
      opoo "Backing up all known pear.conf and .pearrc files"
      opoo <<-INFO
If you have a pre-existing pear install outside
         of homebrew-php, or you are using a non-standard
         pear.conf location, installation may fail.
INFO
      mv(config_pear, "#{config_pear}-backup") if File.exists? config_pear
      mv(user_pear, "#{user_pear}-backup") if File.exists? user_pear
      mv(config_pearrc, "#{config_pearrc}-backup") if File.exists? config_pearrc
      mv(user_pearrc, "#{user_pearrc}-backup") if File.exists? user_pearrc
    end

    begin
      _install
      rm_f("#{config_pear}-backup") if File.exists? "#{config_pear}-backup"
      rm_f("#{user_pear}-backup") if File.exists? "#{user_pear}-backup"
      rm_f("#{config_pearrc}-backup") if File.exists? "#{config_pearrc}-backup"
      rm_f("#{user_pearrc}-backup") if File.exists? "#{user_pearrc}-backup"
    rescue Exception => e
      mv("#{config_pear}-backup", config_pear) if File.exists? "#{config_pear}-backup"
      mv("#{user_pear}-backup", user_pear) if File.exists? "#{user_pear}-backup"
      mv("#{config_pearrc}-backup", config_pearrc) if File.exists? "#{config_pearrc}-backup"
      mv("#{user_pearrc}-backup", user_pearrc) if File.exists? "#{user_pearrc}-backup"
      raise
    end
  end

  def apache_apxs
    if build.include? 'homebrew-apxs'
      ['sbin', 'bin'].each do |dir|
        if File.exist?(location = "#{HOMEBREW_PREFIX}/#{dir}/apxs")
          return location
        end
      end
    else
      '/usr/sbin/apxs'
    end
  end

  def install_args
    args = [
      "--prefix=#{prefix}",
      "--localstatedir=#{var}",
      "--sysconfdir=#{config_path}",
      "--with-config-file-path=#{config_path}",
      "--with-config-file-scan-dir=#{config_path}/conf.d",
      "--with-iconv-dir=/usr",
      "--enable-dba",
      "--with-ndbm=/usr",
      "--enable-exif",
      "--enable-soap",
      "--enable-wddx",
      "--enable-ftp",
      "--enable-sockets",
      "--enable-zip",
      "--enable-shmop",
      "--enable-sysvsem",
      "--enable-sysvshm",
      "--enable-sysvmsg",
      "--enable-mbstring",
      "--enable-mbregex",
      "--enable-bcmath",
      "--enable-calendar",
      "--with-zlib=#{Formula.factory('zlib').opt_prefix}",
      "--with-ldap",
      "--with-ldap-sasl=/usr",
      "--with-xmlrpc",
      "--with-kerberos=/usr",
      "--with-xsl=/usr",
      "--with-gd",
      "--enable-gd-native-ttf",
      "--with-freetype-dir=#{Formula.factory('freetype').opt_prefix}",
      "--with-jpeg-dir=#{Formula.factory('jpeg').opt_prefix}",
      "--with-png-dir=#{Formula.factory('libpng').opt_prefix}",
      "--with-gettext=#{Formula.factory('gettext').opt_prefix}",
      "--with-snmp=/usr",
      "--with-libedit",
      "--with-unixODBC=#{Formula.factory('unixodbc').opt_prefix}",
      "--with-pdo-odbc=unixODBC,#{Formula.factory('unixodbc').opt_prefix}",
      "--mandir=#{man}",
      "--with-mhash",
    ]

    args << "--with-curl" if MacOS.version >= :lion
    args << "--with-curl=#{Formula.factory('curl').opt_prefix}" unless MacOS.version >= :lion

    unless MacOS.version >= :lion
      args << "--with-libxml-dir=#{Formula.factory('libxml2').opt_prefix}"
    end

    unless build.include? 'without-bz2'
      args << '--with-bz2=/usr'
    end

    if build.include? 'with-debug'
      args << "--enable-debug"
    else
      args << "--disable-debug"
    end

    if build.include? 'with-homebrew-openssl'
      args << "--with-openssl=" + Formula.factory('openssl').opt_prefix.to_s
    else
      args << "--with-openssl=/usr"
    end

    if build.include? 'with-fpm'
      args << "--enable-fastcgi"
      args << "--enable-fpm"
      args << "--with-fpm-user=_www"
      args << "--with-fpm-group=_www"
      (prefix+'var/log').mkpath
      touch prefix+'var/log/php-fpm.log'
      (prefix+"homebrew-php.josegonzalez.php#{php_version.to_s.gsub('.','')}.plist").write php_fpm_startup_plist
      (prefix+"homebrew-php.josegonzalez.php#{php_version.to_s.gsub('.','')}.plist").chmod 0644
    elsif build.include? 'with-cgi'
      args << "--enable-cgi"
    end

    # Build Apache module by default
    if build_apache?
      args << "--with-apxs2=#{apache_apxs}"
      args << "--libexecdir=#{libexec}"
    end

    if build.include? 'with-gmp'
      args << "--with-gmp=#{Formula.factory('gmp').opt_prefix}"
    end

    if build.include? 'with-imap'
      args << "--with-imap=#{Formula.factory('imap-uw').opt_prefix}"
      args << "--with-imap-ssl=/usr"
    end

    if build.include? 'with-intl'
      opoo "INTL is broken as of mxcl/homebrew#03ed757c, please install php#{php_version_path.to_s}-intl" unless build_intl?
      args << "--enable-intl" if build_intl?
      args << "--with-icu-dir=#{Formula.factory('icu4c').opt_prefix}" if build_intl?
    end

    if build.include? 'with-mssql'
      args << "--with-mssql=#{Formula.factory('freetds').opt_prefix}"
      args << "--with-pdo-dblib=#{Formula.factory('freetds').opt_prefix}"
    end

    if build.include? 'with-libmysql'
      args << "--with-mysql-sock=/tmp/mysql.sock"
      args << "--with-mysqli=#{HOMEBREW_PREFIX}/bin/mysql_config"
      args << "--with-mysql=#{HOMEBREW_PREFIX}"
      args << "--with-pdo-mysql=#{HOMEBREW_PREFIX}"
    elsif !build.include? 'without-mysql'
      args << "--with-mysql-sock=/tmp/mysql.sock"
      args << "--with-mysqli=mysqlnd"
      args << "--with-mysql=mysqlnd"
      args << "--with-pdo-mysql=mysqlnd"
    end

    if build.include?('with-pgsql')
      if File.directory?(Formula.factory('postgresql').opt_prefix.to_s)
        args << "--with-pgsql=#{Formula.factory('postgresql').opt_prefix}"
        args << "--with-pdo-pgsql=#{Formula.factory('postgresql').opt_prefix}"
      else
        args << "--with-pgsql=#{`pg_config --includedir`}"
        args << "--with-pdo-pgsql=#{`which pg_config`}"
      end
    end

    if build.include? 'with-tidy'
      args << "--with-tidy=#{Formula.factory('tidy').opt_prefix}"
    end

    if build.include? 'without-pear'
      args << "--without-pear"
    end

    if build.include? 'with-thread-safety'
      args << "--enable-maintainer-zts"
    end

    unless build.include? 'without-pcntl'
      args << "--enable-pcntl"
    end

    args
  end

  def default_config
    "./php.ini-development"
  end

  def skip_pear_config_set?
    build.include? 'without-pear'
  end

  def patches
    # Bug in PHP 5.x causes build to fail on OSX 10.5 Leopard due to
    # outdated system libraries being first on library search path:
    # https://bugs.php.net/bug.php?id=44294
    "https://raw.github.com/gist/4222668/923819a243f3b6fefb79471671dbc8baff6e72b7/Makefile.global.diff" if MacOS.version == :leopard
  end

  def _install
    args = install_args

    system "./buildconf" if build.head?
    system "./configure", *args

    # https://bugs.php.net/bug.php?id=62460
    if php_version.to_s == '5.3'
      inreplace "Makefile",
        'EXEEXT = .dSYM',
        'EXEEXT = '
    end

    if build_apache?
      # Use Homebrew prefix for the Apache libexec folder
      inreplace "Makefile",
        /^INSTALL_IT = \$\(mkinstalldirs\) '([^']+)' (.+) LIBEXECDIR=([^\s]+) (.+)$/,
        "INSTALL_IT = $(mkinstalldirs) '#{libexec}/apache2' \\2 LIBEXECDIR='#{libexec}/apache2' \\4"
    end

    if build.include?('with-intl') && build_intl?
      inreplace 'Makefile' do |s|
        s.change_make_var! "EXTRA_LIBS", "\\1 -lstdc++"
      end
    end

    system "make"
    ENV.deparallelize # parallel install fails on some systems
    system "make install"

    config_path.install default_config => "php.ini" unless File.exists? config_path+"php.ini"

    chmod_R 0775, lib+"php"

    system bin+"pear", "config-set", "php_ini", config_path+"php.ini" unless skip_pear_config_set?

    if build.include? 'with-fpm'
      if File.exists?('sapi/fpm/init.d.php-fpm')
        sbin.install 'sapi/fpm/init.d.php-fpm' => "php#{php_version_path.to_s}-fpm"
      end

      if File.exists?('sapi/cgi/fpm/php-fpm')
        sbin.install 'sapi/cgi/fpm/php-fpm' => "php#{php_version_path.to_s}-fpm"
      end

      if !File.exists?(config_path+"php-fpm.conf")
        if File.exists?('sapi/fpm/php-fpm.conf')
          config_path.install 'sapi/fpm/php-fpm.conf'
        end

        if File.exists?('sapi/cgi/fpm/php-fpm.conf')
          config_path.install 'sapi/cgi/fpm/php-fpm.conf'
        end

        inreplace config_path+"php-fpm.conf" do |s|
          s.sub!(/^;?daemonize\s*=.+$/,'daemonize = no')
          s.sub!(/^;include\s*=.+$/,";include=#{config_path}/fpm.d/*.conf")
          s.sub!(/^;?pm\.max_children\s*=.+$/,'pm.max_children = 10')
          s.sub!(/^;?pm\.start_servers\s*=.+$/,'pm.start_servers = 3')
          s.sub!(/^;?pm\.min_spare_servers\s*=.+$/,'pm.min_spare_servers = 2')
          s.sub!(/^;?pm\.max_spare_servers\s*=.+$/,'pm.max_spare_servers = 5')
        end
      end
    end
  end

  def caveats
    s = []

    if build_apache?
      if MacOS.version <= :leopard
        s << <<-EOS.undent
          For 10.5 and Apache:
              Apache needs to run in 32-bit mode. You can either force Apache to start
              in 32-bit mode or you can thin the Apache executable.
        EOS
      end

      s << <<-EOS.undent
        To enable PHP in Apache add the following to httpd.conf and restart Apache:
            LoadModule php5_module    #{HOMEBREW_PREFIX}/opt/php#{php_version_path.to_s}/libexec/apache2/libphp5.so
      EOS
    end

    s << <<-EOS.undent
      The php.ini file can be found in:
          #{config_path}/php.ini
    EOS

    unless build.include? 'without-pear'
      s << <<-EOS.undent
        ✩✩✩✩ PEAR ✩✩✩✩

        If PEAR complains about permissions, 'fix' the default PEAR permissions and config:
            chmod -R ug+w #{lib}/php
            pear config-set php_ini #{etc}/php/#{php_version.to_s}/php.ini
      EOS
    end

    s << <<-EOS.undent
      ✩✩✩✩ Extensions ✩✩✩✩

      If you are having issues with custom extension compiling, ensure that this php is
      in your PATH:
          PATH="$(brew --prefix josegonzalez/php/php#{php_version_path.to_s})/bin:$PATH"

      PHP#{php_version_path.to_s} Extensions will always be compiled against this PHP. Please install them
      using --without-homebrew-php to enable compiling against system PHP.
    EOS

    if build.include?('with-intl') && !build_intl?
    s << <<-EOS.undent
      ✩✩✩✩✩ INTL Support ✩✩✩✩✩

      icu4c is broken as of mxcl/homebrew#03ed757c, so you will need to install intl as
      a separate extension:

          brew install php#{php_version_path.to_s}-intl
    EOS
    end

    if build.include?('with-mcrypt')
    s << <<-EOS.undent
      ✩✩✩✩  Mcrypt ✩✩✩✩

      mcrypt is no longer included by default, install it as a separate extension:

          brew install php#{php_version_path.to_s}-mcrypt
    EOS
    end


    if build.include? 'with-fpm'
      s << <<-EOS.undent
        ✩✩✩✩ FPM ✩✩✩✩

        To launch php-fpm on startup:
            * If this is your first install:
                mkdir -p ~/Library/LaunchAgents
                cp #{prefix}/homebrew-php.josegonzalez.php#{php_version_path.to_s}.plist ~/Library/LaunchAgents/
                launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php#{php_version_path.to_s}.plist

            * If this is an upgrade and you already have the homebrew-php.josegonzalez.php#{php_version_path.to_s}.plist loaded:
                launchctl unload -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php#{php_version_path.to_s}.plist
                cp #{prefix}/homebrew-php.josegonzalez.php#{php_version_path.to_s}.plist ~/Library/LaunchAgents/
                launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php#{php_version_path.to_s}.plist

        The control script is located at #{sbin}/php#{php_version_path.to_s}-fpm
      EOS

      if MacOS.version >= :mountain_lion
        s << <<-EOS.undent
          Mountain Lion comes with php-fpm pre-installed, to ensure you are using the brew version you need to make sure #{HOMEBREW_PREFIX}/sbin is before /usr/sbin in your PATH:

            PATH="#{HOMEBREW_PREFIX}/sbin:$PATH"
        EOS
      end

      s << <<-EOS.undent
        You may also need to edit the plist to use the correct "UserName".

        Please note that the plist was called 'org.php-fpm.plist' in old versions
        of this formula.
      EOS
    end

    s.join "\n"
  end

  def test
    if build.include?('with-fpm')
      system "#{sbin}/php-fpm -y #{config_path}/php-fpm.conf -t"
    end
  end

  def php_fpm_startup_plist; <<-EOPLIST.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>homebrew-php.josegonzalez.php#{php_version_path.to_s}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{sbin}/php-fpm</string>
        <string>--fpm-config</string>
        <string>#{config_path}/php-fpm.conf</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>LaunchOnlyOnce</key>
      <true/>
      <key>UserName</key>
      <string>#{`whoami`.chomp}</string>
      <key>WorkingDirectory</key>
      <string>#{var}</string>
      <key>StandardErrorPath</key>
      <string>#{prefix}/var/log/php-fpm.log</string>
    </dict>
    </plist>
    EOPLIST
  end

end
