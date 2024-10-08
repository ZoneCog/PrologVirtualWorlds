// Copyright � 2000 Microsoft Corporation.  All rights reserved.
// In installing/viewing this source code, you agree to the terms of the
// Microsoft Research Source License (MSRSL) included in the root of this source tree
// and available from http://www.vworlds.org/license.asp.

// VW3DBufO.h : Declaration of CSound3DBufferObject

#include <resource.h>

#include <mmreg.h>
#include <dsound.h>
#include <VWSound.h>

#include <propbase.h>

EXTERN_C const IID LIBID_VWMMLib;
EXTERN_C const CLSID CLSID_Sound3DBuffer;

/////////////////////////////////////////////////////////////////////////////
// CSound3DBufferObject

class ATL_NO_VTABLE CSound3DBufferObject :
	public IDispatchImpl<ISound3DBuffer, &IID_ISound3DBuffer, &LIBID_VWMMLib>,
	public ISupportErrorInfo,
	public CComObjectRootEx<CComMultiThreadModel>,
	public CComCoClass<CSound3DBufferObject, &CLSID_Sound3DBuffer>
{
DECLARE_AGGREGATABLE(CSound3DBufferObject)

public:
	CSound3DBufferObject();
	~CSound3DBufferObject();

BEGIN_COM_MAP(CSound3DBufferObject)
	COM_INTERFACE_ENTRY(IDispatch)
	COM_INTERFACE_ENTRY(ISoundBuffer)
	COM_INTERFACE_ENTRY(ISound3DBuffer)
	COM_INTERFACE_ENTRY(ISupportErrorInfo)
END_COM_MAP()

//DECLARE_NOT_AGGREGATABLE(CSound3DBufferObject) 
// Remove the comment from the line above if you don't want your object to 
// support aggregation.  The default is to support it

DECLARE_REGISTRY(CSound3DBufferObject, _T("VWSYSTEM.Sound3DBuffer.1"), _T("VWSYSTEM.Sound3DBuffer"), IDS_SOUND3DBUFFER_DESC, THREADFLAGS_BOTH)

// ISupportsErrorInfo
	STDMETHOD(InterfaceSupportsErrorInfo)(REFIID riid);

// ISoundBuffer
public:
	STDMETHOD(Initialize)(IVWSound *psound, BSTR bstrFile, int nDSHandle);
	STDMETHOD(SetVolume)(int nVolume);
	STDMETHOD(SetPan)(int nPan) { return E_NOTIMPL; };
	STDMETHOD(SetFrequency)(int nFrequency) { return E_NOTIMPL; };
	STDMETHOD(Play)(VARIANT_BOOL bLoop);
	STDMETHOD(Stop)();
	STDMETHOD(GetStatus)(int *pnStatus);

// ISound3DBuffer
public:
	STDMETHOD(SetConeAngles)(int nInsideCone, int nOutsideCone );
	STDMETHOD(SetConeOrientation)( IVector *pvector );
	STDMETHOD(SetConeOutsideVolume)( int nVolume );
	STDMETHOD(SetMaxDistance)( float flDistance );
	STDMETHOD(SetMinDistance)( float flDistance );
	STDMETHOD(SetPosition)( IVector *pvector );

protected:
	IVWSound *				m_psound;
	CString					m_strFile;
	IDirectSoundBuffer	*	m_pbuf;
	IDirectSound3DBuffer *	m_pbuf3D;
};
