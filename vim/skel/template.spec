%define	%DEFINITION%		%EXPANSION%

Name:		%NAME%
Version:	%VERSION%
Release:	%RELEASE%
Summary:	%SUMMARY%
License:	%LICENCE%
Group:		%GROUP%
URL:		%URL%
Source0:	%SRC%
Patch0:		%PATCH%
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}
BuildRequires:	%REQ%
Requires:	%REQ%

%description
%DESC%

%prep
%setup -q

%build
%configure
make %{?_smp_mflags}

%install
%__rm -rf %{buildroot}
make install DESTDIR=%{buildroot}

%check

%clean
%__rm -rf %{buildroot}

%package -n %PKG_SUB_NAME%
Version:	%VERSION%
Group:		%GROUP%
Summary:	%SUMMARY%

%description -n %PKG_SUB_NAME%
Requires:	%REQ%

%pretrans
%pre
%post
%triggerin
%triggerun
%preun
%postun
%triggerpostun
%posttrans

%pretrans	-n %PKG_SUB_NAME%
%pre		-n %PKG_SUB_NAME%
%post		-n %PKG_SUB_NAME%
%triggerin	-n %PKG_SUB_NAME%
%triggerun	-n %PKG_SUB_NAME%
%preun		-n %PKG_SUB_NAME%
%postun		-n %PKG_SUB_NAME%
%triggerpostun	-n %PKG_SUB_NAME%
%posttrans	-n %PKG_SUB_NAME%

%files
%defattr(-,root,root,-)
%doc

%files -n %PKG_SUB_NAME%
%defattr(-,root,root,-)
%doc

%changelog
* %DAY% %MON% %DOM% %YEAR% - %YOUR NAME% %YOUR EMAIL%
- %description of change
