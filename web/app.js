(function() {
    'use strict';

    // State
    const state = {
        selectedExampleIndex: 0,
        selectedPassIndex: 0,
        viewMode: 'output' // 'output' or 'diff'
    };

    // Elements
    const elements = {
        examplesList: document.getElementById('examples-list'),
        sourceCode: document.getElementById('source-code').querySelector('code'),
        pipelineStrip: document.getElementById('pipeline-strip'),
        passName: document.getElementById('pass-name'),
        passDescription: document.getElementById('pass-description'),
        passPhase: document.getElementById('pass-phase'),
        outputCode: document.getElementById('output-code').querySelector('code'),
        outputView: document.getElementById('output-view'),
        diffView: document.getElementById('diff-view'),
        diffLeftLabel: document.getElementById('diff-left-label'),
        diffLeft: document.getElementById('diff-left').querySelector('code'),
        diffRightLabel: document.getElementById('diff-right-label'),
        diffRight: document.getElementById('diff-right').querySelector('code'),
        toggleOutput: document.getElementById('toggle-output'),
        toggleDiff: document.getElementById('toggle-diff'),
        outputContainer: document.getElementById('output-container')
    };

    // Data
    const examples = COMPILER_DATA.examples;
    const passes = COMPILER_DATA.passes;

    // Get current selections
    function getCurrentExample() {
        return examples[state.selectedExampleIndex];
    }

    function getCurrentPass() {
        return passes[state.selectedPassIndex];
    }

    // Determine pass phase
    function getPassPhase(passId) {
        const backendPasses = ['lfun', 'tc1', 'sh', 'un', 'rf', 'lf', 'tc1b', 'ea', 'ug', 'rc', 'ec', 'tc2', 'ru'];
        return backendPasses.includes(passId) ? 'backend' : 'frontend';
    }

    // Syntax highlighters
    function highlightScheme(code) {
        let result = escapeHtml(code);
        
        // Comments (;; ...)
        result = result.replace(/(;{2,}[^\n]*)/g, '<span class="syn-comment">$1</span>');
        
        // Keywords
        const keywords = ['define', 'if', 'let', 'set!', 'begin', 'while', 'void', 'and', 'or', 'not'];
        keywords.forEach(kw => {
            const regex = new RegExp(`\\b(${kw})\\b`, 'g');
            result = result.replace(regex, '<span class="syn-keyword">$1</span>');
        });
        
        // Vector keywords
        const vecKeywords = ['vector', 'vector-ref', 'vector-set!', 'vector-length'];
        vecKeywords.forEach(kw => {
            const regex = new RegExp(`\\b(${kw.replace(/[!-]/g, '\\$&')})\\b`, 'g');
            result = result.replace(regex, '<span class="syn-keyword">$1</span>');
        });
        
        // Types
        const types = ['Integer', 'Boolean', 'Void', 'Vector'];
        types.forEach(t => {
            const regex = new RegExp(`\\b(${t})\\b`, 'g');
            result = result.replace(regex, '<span class="syn-type">$1</span>');
        });
        
        // Operators
        const operators = ['\\+', '-', '=', '<', '<=', '>', '>='];
        operators.forEach(op => {
            result = result.replace(new RegExp(`(\\(${op})`, 'g'), '(<span class="syn-operator">' + op + '</span>');
        });
        
        // Read/Print
        result = result.replace(/\b(read|print)\b/g, '<span class="syn-operator">$1</span>');
        
        // Numbers
        result = result.replace(/\b(\d+)\b/g, '<span class="syn-number">$1</span>');
        
        // Booleans
        result = result.replace(/#t|#f/g, '<span class="syn-boolean">$&</span>');
        
        // Parentheses
        result = result.replace(/([()])/g, '<span class="syn-paren">$1</span>');
        
        return result;
    }

    function highlightSExp(code) {
        let result = escapeHtml(code);
        
        // Keywords (AST constructors)
        const keywords = [
            'Program', 'Def', 'Let', 'If', 'Prim', 'While', 'Begin', 'Var', 'Int', 'Bool', 
            'FunRef', 'Apply', 'SetBang', 'Vec', 'VecLen', 'VecRef', 'VecSet', 'Void', 
            'Atm', 'Assign', 'Return', 'Seq', 'Goto', 'IfStmt', 'TailCall', 'Call', 
            'Collect', 'Allocate', 'GlobalVal', 'Block', 'CProgram', 'X86Program', 
            'Finfo', 'Finfo1', 'Finfo2', 'Finfo3', 'Binfo1', 'Binfo2', 'Label'
        ];
        keywords.forEach(kw => {
            const regex = new RegExp(`\\b(${kw})\\b`, 'g');
            result = result.replace(regex, '<span class="syn-keyword">$1</span>');
        });
        
        // Types
        const types = ['Integer', 'Boolean', 'Vector', 'Function', 'Unit'];
        types.forEach(t => {
            const regex = new RegExp(`\\b(${t})\\b`, 'g');
            result = result.replace(regex, '<span class="syn-type">$1</span>');
        });
        
        // Operators
        const operators = ['Add', 'Sub', 'Negate', 'Eq', 'Lt', 'Le', 'Gt', 'Ge', 'Not', 'Read', 'Print', 'Sar'];
        operators.forEach(op => {
            const regex = new RegExp(`\\b(${op})\\b`, 'g');
            result = result.replace(regex, '<span class="syn-operator">$1</span>');
        });
        
        // Numbers
        result = result.replace(/\b(\d+)\b/g, '<span class="syn-number">$1</span>');
        
        // Booleans
        result = result.replace(/\b(true|false)\b/g, '<span class="syn-boolean">$1</span>');
        
        // Registers
        const registers = ['Rax', 'Rbx', 'Rcx', 'Rdx', 'Rsi', 'Rdi', 'Rsp', 'Rbp', 'R8', 'R9', 'R10', 'R11', 'R12', 'R13', 'R14', 'R15'];
        registers.forEach(reg => {
            const regex = new RegExp(`\\b(${reg})\\b`, 'g');
            result = result.replace(regex, '<span class="syn-register">$1</span>');
        });
        
        // Instructions
        const instructions = [
            'Movq', 'Addq', 'Subq', 'Negq', 'Xorq', 'Cmpq', 'Pushq', 'Popq', 'Leaq', 
            'Callq', 'Retq', 'Jmp', 'JmpIf', 'TailJmp', 'Set', 'Movzbq', 'Andq', 'Sarq', 
            'IndirectCallq'
        ];
        instructions.forEach(inst => {
            const regex = new RegExp(`\\b(${inst})\\b`, 'g');
            result = result.replace(regex, '<span class="syn-instruction">$1</span>');
        });
        
        // Special forms
        result = result.replace(/\b(args|ret|body|locals|nparams|conflicts|initial|afters|num_spilled|num_spilled_root|used_callee)\b/g, 
            '<span class="syn-keyword">$1</span>');
        
        // VarL, RegL
        result = result.replace(/\b(VarL|RegL)\b/g, '<span class="syn-keyword">$1</span>');
        
        // Imm
        result = result.replace(/\b(Imm)\b/g, '<span class="syn-keyword">$1</span>');
        
        // Parentheses
        result = result.replace(/([()])/g, '<span class="syn-paren">$1</span>');
        
        return result;
    }

    function highlightAsm(code) {
        let result = escapeHtml(code);
        const lines = result.split('\n');
        
        return lines.map(line => {
            let highlighted = line;
            
            // Comments
            if (highlighted.trim().startsWith('#')) {
                return '<span class="syn-comment">' + highlighted + '</span>';
            }
            
            // Labels (word followed by colon at start or after whitespace)
            highlighted = highlighted.replace(/^(\s*)([a-zA-Z_][a-zA-Z0-9_]*:)/, '$1<span class="syn-label">$2</span>');
            
            // Directives
            highlighted = highlighted.replace(/(\.globl|\.align|\.text|\.data|\.section|\.type|\.size)/g, 
                '<span class="syn-directive">$1</span>');
            
            // Instructions
            const instructions = [
                'movq', 'addq', 'subq', 'negq', 'pushq', 'popq', 'leaq', 'callq', 'retq', 
                'jmp', 'jne', 'je', 'jl', 'jg', 'jle', 'jge', 'xorq', 'cmpq', 'movzbq', 
                'andq', 'sarq', 'sete', 'setl', 'setg', 'setle', 'setge', 'setne', 'imulq', 'cqto'
            ];
            instructions.forEach(inst => {
                const regex = new RegExp(`\\b(${inst})\\b`, 'g');
                highlighted = highlighted.replace(regex, '<span class="syn-instruction">$1</span>');
            });
            
            // Registers (%rax etc.)
            highlighted = highlighted.replace(/%[a-zA-Z0-9]+/g, '<span class="syn-register">$&</span>');
            
            // Immediates ($123)
            highlighted = highlighted.replace(/\$(-?\d+)/g, '<span class="syn-imm">$&</span>');
            
            // Numbers
            highlighted = highlighted.replace(/(?<![a-zA-Z%\$])(\d+)(?![a-zA-Z])/g, '<span class="syn-number">$1</span>');
            
            return highlighted;
        }).join('\n');
    }

    function highlightOutput(code, passId) {
        if (passId === 'pa') {
            return highlightAsm(code);
        }
        return highlightSExp(code);
    }

    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Render functions
    function renderExamples() {
        elements.examplesList.innerHTML = examples.map((example, index) => `
            <div class="example-card ${index === state.selectedExampleIndex ? 'selected' : ''}" 
                 data-index="${index}">
                <div class="example-card-title">${escapeHtml(example.title)}</div>
                <div class="example-card-desc">${escapeHtml(example.description)}</div>
            </div>
        `).join('');
        
        // Add click handlers
        document.querySelectorAll('.example-card').forEach(card => {
            card.addEventListener('click', () => {
                const index = parseInt(card.dataset.index);
                selectExample(index);
            });
        });
    }

    function renderPipeline() {
        let html = '';
        passes.forEach((pass, index) => {
            const phase = getPassPhase(pass.id);
            html += `
                <div class="pass-pill">
                    <div class="pass-node ${phase} ${index === state.selectedPassIndex ? 'selected' : ''}" 
                         data-index="${index}">
                        ${escapeHtml(pass.id)}
                    </div>
                    ${index < passes.length - 1 ? '<span class="pass-arrow">→</span>' : ''}
                </div>
            `;
        });
        elements.pipelineStrip.innerHTML = html;
        
        // Add click handlers
        document.querySelectorAll('.pass-node').forEach(node => {
            node.addEventListener('click', () => {
                const index = parseInt(node.dataset.index);
                selectPass(index);
            });
        });
        
        // Scroll selected into view
        const selectedNode = elements.pipelineStrip.querySelector('.pass-node.selected');
        if (selectedNode) {
            selectedNode.scrollIntoView({ behavior: 'smooth', inline: 'center', block: 'nearest' });
        }
    }

    function renderSource() {
        const example = getCurrentExample();
        const highlighted = highlightScheme(example.source);
        elements.sourceCode.innerHTML = addLineNumbers(highlighted);
    }

    function renderPassDetails() {
        const pass = getCurrentPass();
        const phase = getPassPhase(pass.id);
        
        elements.passName.textContent = pass.name;
        elements.passDescription.textContent = pass.description;
        elements.passPhase.textContent = phase === 'backend' ? 'Backend' : 'Frontend';
        elements.passPhase.className = `pass-phase ${phase}`;
    }

    function renderOutput() {
        const example = getCurrentExample();
        const pass = getCurrentPass();
        const output = example.passOutputs[pass.id];
        
        if (state.viewMode === 'output') {
            elements.outputView.classList.remove('hidden');
            elements.diffView.classList.add('hidden');
            
            const highlighted = highlightOutput(output, pass.id);
            elements.outputCode.innerHTML = addLineNumbers(highlighted);
        } else {
            elements.outputView.classList.add('hidden');
            elements.diffView.classList.remove('hidden');
            
            renderDiff();
        }
    }

    function addLineNumbers(code) {
        const lines = code.split('\n');
        return lines.map(line => `<span class="code-line">${line}</span>`).join('\n');
    }

    function renderDiff() {
        const example = getCurrentExample();
        const pass = getCurrentPass();
        const currentOutput = example.passOutputs[pass.id];
        
        let previousOutput;
        let leftLabel;
        
        if (state.selectedPassIndex === 0) {
            // First pass - show source vs output
            previousOutput = example.source;
            leftLabel = 'Source';
        } else {
            const previousPass = passes[state.selectedPassIndex - 1];
            previousOutput = example.passOutputs[previousPass.id];
            leftLabel = previousPass.name;
        }
        
        elements.diffLeftLabel.textContent = leftLabel;
        elements.diffRightLabel.textContent = pass.name;
        
        // Simple line-by-line diff
        const prevLines = previousOutput.split('\n');
        const currLines = currentOutput.split('\n');
        
        const diff = computeDiff(prevLines, currLines);
        
        const leftHtml = diff.left.map((line, i) => {
            const lineClass = line.type === 'removed' ? 'line-removed' : '';
            return `<span class="code-line ${lineClass}">${escapeHtml(line.content)}</span>`;
        }).join('\n');
        
        const rightHtml = diff.right.map((line, i) => {
            const lineClass = line.type === 'added' ? 'line-added' : '';
            return `<span class="code-line ${lineClass}">${escapeHtml(line.content)}</span>`;
        }).join('\n');
        
        // Apply syntax highlighting
        if (state.selectedPassIndex === 0) {
            elements.diffLeft.innerHTML = highlightScheme(leftHtml.replace(/<span class="code-line([^"]*)">/g, 
                (match, cls) => {
                    const processed = highlightScheme(match);
                    return processed.replace(/class="code-line/, 'class="code-line ' + cls.trim());
                }));
        } else {
            const prevPassId = passes[state.selectedPassIndex - 1].id;
            elements.diffLeft.innerHTML = highlightOutput(leftHtml, prevPassId);
        }
        elements.diffRight.innerHTML = highlightOutput(rightHtml, pass.id);
    }

    function computeDiff(prevLines, currLines) {
        // Simple LCS-based diff
        const result = { left: [], right: [] };
        let i = 0, j = 0;
        
        // Build a simple LCS matrix for small inputs
        const lcs = buildLCS(prevLines, currLines);
        
        // Backtrack through LCS
        let li = prevLines.length;
        let lj = currLines.length;
        const leftResult = [];
        const rightResult = [];
        
        while (li > 0 || lj > 0) {
            if (li > 0 && lj > 0 && prevLines[li - 1] === currLines[lj - 1]) {
                leftResult.unshift({ content: prevLines[li - 1], type: 'unchanged' });
                rightResult.unshift({ content: currLines[lj - 1], type: 'unchanged' });
                li--;
                lj--;
            } else if (lj > 0 && (li === 0 || lcs[li][lj - 1] >= lcs[li - 1][lj])) {
                rightResult.unshift({ content: currLines[lj - 1], type: 'added' });
                lj--;
            } else if (li > 0) {
                leftResult.unshift({ content: prevLines[li - 1], type: 'removed' });
                li--;
            }
        }
        
        return { left: leftResult, right: rightResult };
    }

    function buildLCS(a, b) {
        const m = a.length;
        const n = b.length;
        const dp = [];
        
        for (let i = 0; i <= m; i++) {
            dp[i] = [];
            for (let j = 0; j <= n; j++) {
                if (i === 0 || j === 0) {
                    dp[i][j] = 0;
                } else if (a[i - 1] === b[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1] + 1;
                } else {
                    dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
                }
            }
        }
        
        return dp;
    }

    // Selection functions
    function selectExample(index) {
        if (index >= 0 && index < examples.length) {
            state.selectedExampleIndex = index;
            renderExamples();
            renderSource();
            renderOutput();
        }
    }

    function selectPass(index) {
        if (index >= 0 && index < passes.length) {
            state.selectedPassIndex = index;
            renderPipeline();
            renderPassDetails();
            renderOutput();
        }
    }

    function setViewMode(mode) {
        state.viewMode = mode;
        elements.toggleOutput.classList.toggle('active', mode === 'output');
        elements.toggleDiff.classList.toggle('active', mode === 'diff');
        renderOutput();
    }

    // Keyboard navigation
    function handleKeydown(e) {
        switch (e.key) {
            case 'ArrowLeft':
                e.preventDefault();
                selectPass(state.selectedPassIndex - 1);
                break;
            case 'ArrowRight':
                e.preventDefault();
                selectPass(state.selectedPassIndex + 1);
                break;
            case 'ArrowUp':
                e.preventDefault();
                selectExample(state.selectedExampleIndex - 1);
                break;
            case 'ArrowDown':
                e.preventDefault();
                selectExample(state.selectedExampleIndex + 1);
                break;
        }
    }

    // Sync diff scroll
    function syncDiffScroll() {
        const leftPre = elements.diffLeft.parentElement;
        const rightPre = elements.diffRight.parentElement;
        
        let syncing = false;
        
        leftPre.addEventListener('scroll', () => {
            if (syncing) return;
            syncing = true;
            rightPre.scrollTop = leftPre.scrollTop;
            rightPre.scrollLeft = leftPre.scrollLeft;
            setTimeout(() => syncing = false, 10);
        });
        
        rightPre.addEventListener('scroll', () => {
            if (syncing) return;
            syncing = true;
            leftPre.scrollTop = rightPre.scrollTop;
            leftPre.scrollLeft = rightPre.scrollLeft;
            setTimeout(() => syncing = false, 10);
        });
    }

    // Initialize
    function init() {
        renderExamples();
        renderPipeline();
        renderSource();
        renderPassDetails();
        renderOutput();
        syncDiffScroll();
        
        // View toggle
        elements.toggleOutput.addEventListener('click', () => setViewMode('output'));
        elements.toggleDiff.addEventListener('click', () => setViewMode('diff'));
        
        // Keyboard navigation
        document.addEventListener('keydown', handleKeydown);
    }

    // Start
    init();
})();
