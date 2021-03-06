/* -*-Mode: C++-*-
 *
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
 *
 * ScenarioParser : Parser for Scenario File
 */
#if !defined(__TgScenario_h__)
#define __TgScenario_h__

#include "TgInfo.h"
#include "TgStatement.h"
#include "LxScenario.h"


// ====================================================================
//	ScenarioParser : Parser class
// ====================================================================

#define MAX_DATA_SIZE  65535
#define MAX_DATA_COUNT 65535

class ScenarioParser {
protected:
	ScenarioLexer  lexer_;	// Lexer Instance

	TgInfoConnCltn* connList_;
	TgInfoEventCltn* eventList_;
	TgInfoActionCltn* actionList_;
	TgInfoScenarioCltn* scenarioList_;
	TgStatementCltn* statementList_;
	TgInfoPort* srcPort_;
	TgInfoPort* dstPort_;
	CStringList* nameList_;

public:
	ScenarioParser(CSTR);
virtual	~ScenarioParser( );

	//  Parser Info
	uint32_t errors() const {return lexer_.errorCount();};	

	//	Scenario File
	TgInfoScenarioFile* ScenarioFile();

	//	method to handle Node
	void ConnectStatement(CmCString*, TgInfoConn::Protocol);
	void EventStatement(CmCString*);
	void TrafficStatement(CmCString*, CmCString*);
	void ExecuteStatement(CmCString*, CmCString*);
	void ActConnectStatement();
	void ActDelayStatement(uint32_t);
	void ActOneWayStatement(uint32_t, uint32_t, uint32_t);
	void ActTurnaroundStatement(uint32_t, uint32_t, uint32_t);
	void ActExecuteStatement(CmCString*);
	void ActSyncStatement(CmCString*);
	void ScenarioStatement(CmCString*);
	void NameStatement(CmCString*);
	void SrcPortStatement(CmCString*, CmCString*, uint32_t);
	void DstPortStatement(CmCString*, CmCString*, uint32_t);
public:
static	bool parse(CSTR, TgInfoScenarioFile*&);
	int yyparse();
};

#endif
