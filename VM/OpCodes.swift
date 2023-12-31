//
//  OpCodes.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import Foundation

class OpCodes {
 
      public static let NOP = 0; // visitInsn
      public static let ACONST_NULL = 1; // -
      public static let ICONST_M1 = 2; // -
      public static let ICONST_0 = 3; // -
      public static let ICONST_1 = 4; // -
      public static let ICONST_2 = 5; // -
      public static let ICONST_3 = 6; // -
      public static let ICONST_4 = 7; // -
      public static let ICONST_5 = 8; // -
      public static let LCONST_0 = 9; // -
      public static let LCONST_1 = 10; // -
      public static let FCONST_0 = 11; // -
      public static let FCONST_1 = 12; // -
      public static let FCONST_2 = 13; // -
      public static let DCONST_0 = 14; // -
      public static let DCONST_1 = 15; // -
      public static let BIPUSH = 16; // visitIntInsn
      public static let SIPUSH = 17; // -
      public static let LDC = 18; // visitLdcInsn
      public static let ILOAD = 21; // visitVarInsn
      public static let LLOAD = 22; // -
      public static let FLOAD = 23; // -
      public static let DLOAD = 24; // -
      public static let ALOAD = 25; // -
      public static let IALOAD = 46; // visitInsn
      public static let LALOAD = 47; // -
      public static let FALOAD = 48; // -
      public static let DALOAD = 49; // -
      public static let AALOAD = 50; // -
      public static let BALOAD = 51; // -
      public static let CALOAD = 52; // -
      public static let SALOAD = 53; // -
      public static let ISTORE = 54; // visitVarInsn
      public static let LSTORE = 55; // -
      public static let FSTORE = 56; // -
      public static let DSTORE = 57; // -
      public static let ASTORE = 58; // -
      public static let IASTORE = 79; // visitInsn
      public static let LASTORE = 80; // -
      public static let FASTORE = 81; // -
      public static let DASTORE = 82; // -
      public static let AASTORE = 83; // -
      public static let BASTORE = 84; // -
      public static let CASTORE = 85; // -
      public static let SASTORE = 86; // -
      public static let POP = 87; // -
      public static let POP2 = 88; // -
      public static let DUP = 89; // -
      public static let DUP_X1 = 90; // -
      public static let DUP_X2 = 91; // -
      public static let DUP2 = 92; // -
      public static let DUP2_X1 = 93; // -
      public static let DUP2_X2 = 94; // -
      public static let SWAP = 95; // -
      public static let IADD = 96; // -
      public static let LADD = 97; // -
      public static let FADD = 98; // -
      public static let DADD = 99; // -
      public static let ISUB = 100; // -
      public static let LSUB = 101; // -
      public static let FSUB = 102; // -
      public static let DSUB = 103; // -
      public static let IMUL = 104; // -
      public static let LMUL = 105; // -
      public static let FMUL = 106; // -
      public static let DMUL = 107; // -
      public static let IDIV = 108; // -
      public static let LDIV = 109; // -
      public static let FDIV = 110; // -
      public static let DDIV = 111; // -
      public static let IREM = 112; // -
      public static let LREM = 113; // -
      public static let FREM = 114; // -
      public static let DREM = 115; // -
      public static let INEG = 116; // -
      public static let LNEG = 117; // -
      public static let FNEG = 118; // -
      public static let DNEG = 119; // -
      public static let ISHL = 120; // -
      public static let LSHL = 121; // -
      public static let ISHR = 122; // -
      public static let LSHR = 123; // -
      public static let IUSHR = 124; // -
      public static let LUSHR = 125; // -
      public static let IAND = 126; // -
      public static let LAND = 127; // -
      public static let IOR = 128; // -
      public static let LOR = 129; // -
      public static let IXOR = 130; // -
      public static let LXOR = 131; // -
      public static let IINC = 132; // visitIincInsn
      public static let I2L = 133; // visitInsn
      public static let I2F = 134; // -
      public static let I2D = 135; // -
      public static let L2I = 136; // -
      public static let L2F = 137; // -
      public static let L2D = 138; // -
      public static let F2I = 139; // -
      public static let F2L = 140; // -
      public static let F2D = 141; // -
      public static let D2I = 142; // -
      public static let D2L = 143; // -
      public static let D2F = 144; // -
      public static let I2B = 145; // -
      public static let I2C = 146; // -
      public static let I2S = 147; // -
      public static let LCMP = 148; // -
      public static let FCMPL = 149; // -
      public static let FCMPG = 150; // -
      public static let DCMPL = 151; // -
      public static let DCMPG = 152; // -
      public static let IFEQ = 153; // visitJumpInsn
      public static let IFNE = 154; // -
      public static let IFLT = 155; // -
      public static let IFGE = 156; // -
      public static let IFGT = 157; // -
      public static let IFLE = 158; // -
      public static let IF_ICMPEQ = 159; // -
      public static let IF_ICMPNE = 160; // -
      public static let IF_ICMPLT = 161; // -
      public static let IF_ICMPGE = 162; // -
      public static let IF_ICMPGT = 163; // -
      public static let IF_ICMPLE = 164; // -
      public static let IF_ACMPEQ = 165; // -
      public static let IF_ACMPNE = 166; // -
      public static let GOTO = 167; // -
      public static let JSR = 168; // -
      public static let RET = 169; // visitVarInsn
      public static let TABLESWITCH = 170; // visiTableSwitchInsn
      public static let LOOKUPSWITCH = 171; // visitLookupSwitch
      public static let IRETURN = 172; // visitInsn
      public static let LRETURN = 173; // -
      public static let FRETURN = 174; // -
      public static let DRETURN = 175; // -
      public static let ARETURN = 176; // -
      public static let RETURN = 177; // -
      public static let GETSTATIC = 178; // visitFieldInsn
      public static let PUTSTATIC = 179; // -
      public static let GETFIELD = 180; // -
      public static let PUTFIELD = 181; // -
      public static let INVOKEVIRTUAL = 182; // visitMethodInsn
      public static let INVOKESPECIAL = 183; // -
      public static let INVOKESTATIC = 184; // -
      public static let INVOKEINTERFACE = 185; // -
      public static let INVOKEDYNAMIC = 186; // visitInvokeDynamicInsn
      public static let NEW = 187; // visitTypeInsn
      public static let NEWARRAY = 188; // visitIntInsn
      public static let ANEWARRAY = 189; // visitTypeInsn
      public static let ARRAYLENGTH = 190; // visitInsn
      public static let ATHROW = 191; // -
      public static let CHECKCAST = 192; // visitTypeInsn
      public static let INSTANCEOF = 193; // -
      public static let MONITORENTER = 194; // visitInsn
      public static let MONITOREXIT = 195; // -
      public static let MULTIANEWARRAY = 197; // visitMultiANewArrayInsn
      public static let IFNULL = 198; // visitJumpInsn
      public static let IFNONNULL = 199; // -
}
