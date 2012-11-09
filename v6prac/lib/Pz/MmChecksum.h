/*
 * Copyright (C) 1999,2000 Yokogawa Electric Corporation and
 *                         YDC Corporation.
 * All rights reserved.
 * 
 * Redistribution and use of this software in source and binary
 * forms, with or without modification, are permitted provided that
 * the following conditions and disclaimer are agreed and accepted
 * by the user:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with
 *    the distribution.
 * 
 * 3. Neither the names of the copyrighters, the name of the project
 *    which is related to this software (hereinafter referred to as
 *    "project") nor the names of the contributors may be used to
 *    endorse or promote products derived from this software without
 *    specific prior written permission.
 * 
 * 4. No merchantable use may be permitted without prior written
 *    notification to the copyrighters.
 * 
 * 5. The copyrighters, the project and the contributors may prohibit
 *    the use of this software at any time.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHTERS, THE PROJECT AND
 * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING
 * BUT NOT LIMITED THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE, ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * COPYRIGHTERS, THE PROJECT OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
#if !defined(__MmChecksum_h__)
#define __MmChecksum_h__

#include "MmObject.h"

///////////////////////////////////////////////////////////////////////////////

class MmChecksum : public MmUint{
private:bool optionable_;
	bool usepseudo_;
protected:
	MmChecksum(CSTR s,uint16_t w,bool optionable=false,bool usepseudo=false,
		const ICVoverwriter* ow=0);
public:
virtual ~MmChecksum();
public:
// COMPOSE/REVERSE INTERFACE --------------------------------------------------
virtual RObject* reverseRm(RControl&,RObject* r_parent,
		const ItPosition& at,const ItPosition& size,PvObject* pv)const;
virtual WObject* composeWm(WControl& c,WObject* w_parent,
		const PObject* po)const;
virtual	RObject* reverse(RControl&,RObject* r_parent,
		ItPosition& at,OCTBUF& buf)const;
virtual bool geneAuto(WControl& c,WObject* w_self,OCTBUF& buf)const;
//
virtual void add_post(Con_IPinfo* info,TObject* self)const;
};

class MmUppChecksum : public MmChecksum{
public:
	MmUppChecksum(CSTR s,uint16_t w,
		bool optionable=false,bool usepseudo=true,
		const ICVoverwriter* ow=0);
virtual ~MmUppChecksum();
virtual void add_post(Con_IPinfo* info,TObject* self)const;
};
class MmIPChecksum : public MmChecksum{
public:
	MmIPChecksum(CSTR s,uint16_t w,
		bool optionable=false,const ICVoverwriter* ow=0);
virtual ~MmIPChecksum();
virtual void add_post(Con_IPinfo* info,TObject* self)const;
};

///////////////////////////////////////////////////////////////////////////////
#endif