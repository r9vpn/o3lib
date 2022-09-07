// SWIG interface file for OpenVPN client

// enable director feature for OpenVPNClientBase virtual method callbacks
%module(directors="1") o3lib
%feature("director") OpenVPNClient;
//%feature("director") TunBuilderBase;

%include "std_string.i" // for std::string typemaps
%include "std_vector.i"

// top-level C++ implementation file
%{
#include "core/client/ovpncli.hpp"
%}

// ignore these ClientAPI::OpenVPNClient bases
// %ignore openvpn::ClientAPI::LogReceiver;
%ignore openvpn::ExternalTun::Factory;
%ignore openvpn::ExternalTransport::Factory;
%ignore openvpn::ClientAPI::ExternalPKIRequestBase;

// modify exported C++ class names to incorporate their enclosing namespace
%rename(ClientAPI_OpenVPNClient) OpenVPNClient;
%rename(ClientAPI_OpenVPNClientHelper) OpenVPNClientHelper;
%rename(ClientAPI_TunBuilderBase) TunBuilderBase;
%rename(ClientAPI_ExternalPKIBase) ExternalPKIBase;
%rename(ClientAPI_ServerEntry) ServerEntry;
%rename(ClientAPI_EvalConfig) EvalConfig;
%rename(ClientAPI_ProvideCreds) ProvideCreds;
%rename(ClientAPI_SessionToken) SessionToken;
%rename(ClientAPI_DynamicChallenge) DynamicChallenge;
%rename(ClientAPI_KeyValue) KeyValue;
%rename(ClientAPI_Config) Config;
%rename(ClientAPI_Event) Event;
%rename(ClientAPI_ConnectionInfo) ConnectionInfo;
%rename(ClientAPI_Status) Status;
%rename(ClientAPI_LogInfo) LogInfo;
%rename(ClientAPI_LogReceiver) LogReceiver;
%rename(ClientAPI_InterfaceStats) InterfaceStats;
%rename(ClientAPI_TransportStats) TransportStats;
%rename(ClientAPI_MergeConfig) MergeConfig;
%rename(ClientAPI_ExternalPKIRequestBase) ExternalPKIRequestBase;
%rename(ClientAPI_ExternalPKICertRequest) ExternalPKICertRequest;
%rename(ClientAPI_ExternalPKISignRequest) ExternalPKISignRequest;
%rename(ClientAPI_RemoteOverride) RemoteOverride;

// declare vectors
namespace std {
  %template(ClientAPI_ServerEntryVector) vector<openvpn::ClientAPI::ServerEntry>;
  %template(ClientAPI_LLVector) vector<long long>;
  %template(ClientAPI_StringVec) vector<string>;
};

// interface to be bridged between C++ and target language
%include "core/openvpn/pki/epkibase.hpp"
%include "core/openvpn/tun/builder/base.hpp"
%import  "core/openvpn/tun/extern/fw.hpp"     // ignored
%import  "core/openvpn/transport/client/extern/fw.hpp"     // ignored
%include "core/client/ovpncli.hpp"
