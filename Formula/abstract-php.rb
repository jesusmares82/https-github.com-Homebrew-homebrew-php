#encoding: utf-8

require 'formula'
require File.join(File.dirname(__FILE__), 'abstract-php-version')

def postgres_installed?
  `which pg_config`.length > 0
end

class AbstractPhp < Formula
  def initialize(name, *args)
    begin
      raise "One does not simply install an AbstractPhp formula" if name == "abstract-php"
      super
    rescue Exception => e
      # Hack so that we pass all brew doctor tests
      reraise = e.backtrace.select { |l| l.match(/(doctor|cleanup|leaves|uses)\.rb/) }
      raise e if reraise.empty?
    end
  end

  # Hack to allow 'brew uses' to work, which requires deps, version, and requirements
  %w(deps requirements version).each do |method|
    define_method(method) do
      if defined?(active_spec) && active_spec.respond_to?(method)
        active_spec.send(method)
      else
        method === 'version' ? 'abstract' : []
      end
    end
  end

  def self.init
    homepage 'http://php.net'

    # So PHP extensions don't report missing symbols
    skip_clean 'bin', 'sbin'

    head do
      depends_on 'autoconf' => :build
      depends_on 're2c' => :build
      depends_on 'flex' => :build
      depends_on 'homebrew/versions/bison27' => :build
    end

    depends_on 'curl' if build.include?('with-homebrew-curl') || MacOS.version < :lion
    depends_on 'freetds' if build.include?('with-mssql')
    depends_on 'freetype'
    depends_on 'gettext'
    depends_on 'gmp' => :optional
    depends_on 'icu4c'
    depends_on 'imap-uw' if build.include?('with-imap')
    depends_on 'jpeg'
    depends_on 'libpng'
    depends_on 'libxml2' unless MacOS.version >= :lion
    depends_on 'openssl' if build.include?('with-homebrew-openssl')
    depends_on 'homebrew/dupes/tidy' if build.include?('with-tidy')
    depends_on 'unixodbc'
    depends_on 'homebrew/dupes/zlib'
    depends_on 'libtool' => :build if build.without? 'disable-opcache'

    # Sanity Checks
    if build.with? 'pgsql'
      depends_on 'postgresql' => :recommended unless postgres_installed?
    end

    if build.include?('with-cgi') && build.include?('with-fpm')
      raise "Cannot specify more than one executable to build."
    end

    option 'homebrew-apxs', 'Build against apxs in Homebrew prefix'
    option 'with-homebrew-curl', 'Include Curl support via Homebrew'
    option 'with-debug', 'Compile with debugging symbols'
    option 'with-libmysql', 'Include (old-style) libmysql support instead of mysqlnd'
    option 'without-mysql', 'Remove MySQL/MariaDB support'
    option 'with-pgsql', 'Include PostgreSQL support'
    option 'with-mssql', 'Include MSSQL-DB support'
    option 'with-pdo-oci', 'Include Oracle databases (requries ORACLE_HOME be set)'
    option 'with-cgi', 'Enable building of the CGI executable (implies --without-apache)'
    option 'with-fpm', 'Enable building of the fpm SAPI executable (implies --without-apache)'
    option 'with-phpdbg', 'Enable building of the phpdbg SAPI executable (PHP 5.4 and above)'
    option 'with-apache', 'Enable building of shared Apache 2.0 Handler module, overriding any options which disable apache'
    option 'with-imap', 'Include IMAP extension'
    option 'without-pear', 'Build without PEAR'
    option 'with-tidy', 'Include Tidy support'
    option 'with-thread-safety', 'Build with thread safety'
    option 'with-homebrew-openssl', 'Include OpenSSL support via Homebrew'
    option 'with-homebrew-libxslt', 'Include LibXSLT support via Homebrew'
    option 'without-bz2', 'Build without bz2 support'
    option 'without-pcntl', 'Build without Process Control support'
    option 'disable-opcache', 'Build without Opcache extension'
    option 'disable-zend-multibyte', 'Disable auto-detection of Unicode encoded scripts (PHP 5.2 and 5.3 only)'
  end

  # Fixes the pear .lock permissions issue that keeps it from operating correctly.
  # Thanks mistym & #machomebrew
  skip_clean 'lib/php/.lock'

  def config_path
    etc+"php/"+php_version.to_s
  end

  def home_path
    File.expand_path("~")
  end

  def build_apache?
    build.with?('apache') || !(build.with?('cgi') || build.with?('fpm'))
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
    if File.exist?(config_pear) || File.exist?(user_pear) || File.exist?(config_pearrc) || File.exist?(user_pearrc)
      opoo "Backing up all known pear.conf and .pearrc files"
      opoo <<-INFO
If you have a pre-existing pear install outside
         of homebrew-php, or you are using a non-standard
         pear.conf location, installation may fail.
INFO
      mv(config_pear, "#{config_pear}-backup") if File.exist? config_pear
      mv(user_pear, "#{user_pear}-backup") if File.exist? user_pear
      mv(config_pearrc, "#{config_pearrc}-backup") if File.exist? config_pearrc
      mv(user_pearrc, "#{user_pearrc}-backup") if File.exist? user_pearrc
    end

    begin
      _install
      rm_f("#{config_pear}-backup") if File.exist? "#{config_pear}-backup"
      rm_f("#{user_pear}-backup") if File.exist? "#{user_pear}-backup"
      rm_f("#{config_pearrc}-backup") if File.exist? "#{config_pearrc}-backup"
      rm_f("#{user_pearrc}-backup") if File.exist? "#{user_pearrc}-backup"
    rescue Exception
      mv("#{config_pear}-backup", config_pear) if File.exist? "#{config_pear}-backup"
      mv("#{user_pear}-backup", user_pear) if File.exist? "#{user_pear}-backup"
      mv("#{config_pearrc}-backup", config_pearrc) if File.exist? "#{config_pearrc}-backup"
      mv("#{user_pearrc}-backup", user_pearrc) if File.exist? "#{user_pearrc}-backup"
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

  def default_config
    "./php.ini-development"
  end

  def skip_pear_config_set?
    build.without? 'pear'
  end

  def patches
    # Bug in PHP 5.x causes build to fail on OSX 10.5 Leopard due to
    # outdated system libraries being first on library search path:
    # https://bugs.php.net/bug.php?id=44294
    "https://gist.github.com/ablyler/6579338/raw/5713096862e271ca78e733b95e0235d80fed671a/Makefile.global.diff" if MacOS.version == :leopard
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
      "--enable-intl",
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
      "--with-zlib=#{Formula['zlib'].opt_prefix}",
      "--with-ldap",
      "--with-ldap-sasl=/usr",
      "--with-xmlrpc",
      "--with-kerberos=/usr",
      "--with-gd",
      "--enable-gd-native-ttf",
      "--with-freetype-dir=#{Formula['freetype'].opt_prefix}",
      "--with-icu-dir=#{Formula['icu4c'].opt_prefix}",
      "--with-jpeg-dir=#{Formula['jpeg'].opt_prefix}",
      "--with-png-dir=#{Formula['libpng'].opt_prefix}",
      "--with-gettext=#{Formula['gettext'].opt_prefix}",
      "--with-snmp=/usr",
      "--with-libedit",
      "--with-unixODBC=#{Formula['unixodbc'].opt_prefix}",
      "--with-pdo-odbc=unixODBC,#{Formula['unixodbc'].opt_prefix}",
      "--mandir=#{man}",
      "--with-mhash",
    ]

    if build.include?('with-homebrew-curl') || MacOS.version < :lion
      args << "--with-curl=#{Formula['curl'].opt_prefix}"
    else
      args << "--with-curl"
    end

    unless MacOS.version >= :lion
      args << "--with-libxml-dir=#{Formula['libxml2'].opt_prefix}"
    end

    if build.with? 'bz2'
      args << '--with-bz2=/usr'
    end

    if build.with? 'debug'
      args << "--enable-debug"
    else
      args << "--disable-debug"
    end

    if build.with? 'homebrew-openssl'
      args << "--with-openssl=" + Formula['openssl'].opt_prefix.to_s
    else
      args << "--with-openssl=/usr"
    end

    if build.with? 'homebrew-libxslt'
      args << "--with-xsl=" + Formula['libxslt'].opt_prefix.to_s
    else
      args << "--with-xsl=/usr"
    end

    if build.with? 'fpm'
      args << "--enable-fastcgi"
      args << "--enable-fpm"
      args << "--with-fpm-user=_www"
      args << "--with-fpm-group=_www"
      (prefix+'var/log').mkpath
      touch prefix+'var/log/php-fpm.log'
      plist_path.write plist
      plist_path.chmod 0644
    elsif build.with? 'cgi'
      args << "--enable-cgi"
    end

    # Build Apache module by default
    if build_apache?
      args << "--with-apxs2=#{apache_apxs}"
      args << "--libexecdir=#{libexec}"
    end

    if build.with? 'gmp'
      args << "--with-gmp=#{Formula['gmp'].opt_prefix}"
    end

    if build.with? 'imap'
      args << "--with-imap=#{Formula['imap-uw'].opt_prefix}"
      args << "--with-imap-ssl=/usr"
    end

    if build.with? 'mssql'
      args << "--with-mssql=#{Formula['freetds'].opt_prefix}"
      args << "--with-pdo-dblib=#{Formula['freetds'].opt_prefix}"
    end

    if build.with? 'libmysql'
      args << "--with-mysql-sock=/tmp/mysql.sock"
      args << "--with-mysqli=#{HOMEBREW_PREFIX}/bin/mysql_config"
      args << "--with-mysql=#{HOMEBREW_PREFIX}"
      args << "--with-pdo-mysql=#{HOMEBREW_PREFIX}"
    elsif build.with? 'mysql'
      args << "--with-mysql-sock=/tmp/mysql.sock"
      args << "--with-mysqli=mysqlnd"
      args << "--with-mysql=mysqlnd"
      args << "--with-pdo-mysql=mysqlnd"
    end

    if build.with? 'pgsql'
      if File.directory?(Formula['postgresql'].opt_prefix.to_s)
        args << "--with-pgsql=#{Formula['postgresql'].opt_prefix}"
        args << "--with-pdo-pgsql=#{Formula['postgresql'].opt_prefix}"
      else
        args << "--with-pgsql=#{`pg_config --includedir`}"
        args << "--with-pdo-pgsql=#{`which pg_config`}"
      end
    end

    if build.with? 'pdo-oci'
      if ENV.has_key?('ORACLE_HOME')
        args << "--with-pdo-oci=#{ENV['ORACLE_HOME']}"
      else
        raise "Environmental variable ORACLE_HOME must be set to use --with-pdo-oci option."
      end
    end

    if build.with? 'tidy'
      args << "--with-tidy=#{Formula['tidy'].opt_prefix}"
    end

    if build.without? 'pear'
      args << "--without-pear"
    end

    if build.with? 'thread-safety'
      args << "--enable-maintainer-zts"
    end

    if build.with? 'pcntl'
      args << "--enable-pcntl"
    end

    if build.with? 'phpdbg'
      args << "--enable-phpdbg"
    end

    return args
  end

  def _install
    system "./buildconf" if build.head?
    system "./configure", *install_args()

    if build_apache?
      # Use Homebrew prefix for the Apache libexec folder
      inreplace "Makefile",
        /^INSTALL_IT = \$\(mkinstalldirs\) '([^']+)' (.+) LIBEXECDIR=([^\s]+) (.+)$/,
        "INSTALL_IT = $(mkinstalldirs) '#{libexec}/apache2' \\2 LIBEXECDIR='#{libexec}/apache2' \\4"
    end

    inreplace 'Makefile' do |s|
      s.change_make_var! "EXTRA_LIBS", "\\1 -lstdc++"
    end

    system "make"
    ENV.deparallelize # parallel install fails on some systems
    system "make install"

    config_path.install default_config => "php.ini" unless File.exist? config_path+"php.ini"

    chmod_R 0775, lib+"php"

    system bin+"pear", "config-set", "php_ini", config_path+"php.ini" unless skip_pear_config_set?

    if build.with? 'fpm'
      if File.exist?('sapi/fpm/init.d.php-fpm')
        sbin.install 'sapi/fpm/init.d.php-fpm' => "php#{php_version_path.to_s}-fpm"
      end

      if File.exist?('sapi/cgi/fpm/php-fpm')
        sbin.install 'sapi/cgi/fpm/php-fpm' => "php#{php_version_path.to_s}-fpm"
      end

      if !File.exist?(config_path+"php-fpm.conf")
        if File.exist?('sapi/fpm/php-fpm.conf')
          config_path.install 'sapi/fpm/php-fpm.conf'
        end

        if File.exist?('sapi/cgi/fpm/php-fpm.conf')
          config_path.install 'sapi/cgi/fpm/php-fpm.conf'
        end

        inreplace config_path+"php-fpm.conf" do |s|
          s.sub!(/^;?daemonize\s*=.+$/,'daemonize = no')
          s.sub!(/^;include\s*=.+$/,";include=#{config_path}/fpm.d/*.conf")
          s.sub!(/^;?listen\.mode\s*=.+$/,'listen.mode = 0666')
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

    if build.with? 'pear'
      s << <<-EOS.undent
        ✩✩✩✩ PEAR ✩✩✩✩

        If PEAR complains about permissions, 'fix' the default PEAR permissions and config:
            chmod -R ug+w #{lib}/php
            pear config-set php_ini #{etc}/php/#{php_version.to_s}/php.ini
      EOS
    end

    s << <<-EOS.undent
      ✩✩✩✩ Extensions ✩✩✩✩

      If you are having issues with custom extension compiling, ensure that
      you are using the brew version, by placing #{HOMEBREW_PREFIX}/bin before /usr/sbin in your PATH:

            PATH="#{HOMEBREW_PREFIX}/bin:$PATH"

      PHP#{php_version_path.to_s} Extensions will always be compiled against this PHP. Please install them
      using --without-homebrew-php to enable compiling against system PHP.
    EOS

    s << <<-EOS.undent
      ✩✩✩✩ PHP CLI ✩✩✩✩

      If you wish to swap the PHP you use on the command line, you should add the following to ~/.bashrc,
      ~/.zshrc, ~/.profile or your shell's equivalent configuration file:

            export PATH="$(brew --prefix homebrew/php/php#{php_version.to_s.gsub('.','')})/bin:$PATH"
    EOS

    if build.include?('with-mcrypt')
    s << <<-EOS.undent
      ✩✩✩✩  Mcrypt ✩✩✩✩

      mcrypt is no longer included by default, install it as a separate extension:

          brew install php#{php_version_path.to_s}-mcrypt
    EOS
    end


    if build.include?('with-fpm')
      s << <<-EOS.undent
        ✩✩✩✩ FPM ✩✩✩✩

        To launch php-fpm on startup:
            * If this is your first install:
                mkdir -p ~/Library/LaunchAgents
                cp #{plist_path} ~/Library/LaunchAgents/
                launchctl load -w ~/Library/LaunchAgents/#{plist_name}.plist

            * If this is an upgrade and you already have the #{plist_name}.plist loaded:
                launchctl unload -w ~/Library/LaunchAgents/#{plist_name}.plist
                cp #{plist_path} ~/Library/LaunchAgents/
                launchctl load -w ~/Library/LaunchAgents/#{plist_name}.plist

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

        Please note that the plist was called 'homebrew-php.josegonzalez.php#{php_version.to_s.gsub('.','')}.plist' in old versions
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

  def plist; <<-EOPLIST.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
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
