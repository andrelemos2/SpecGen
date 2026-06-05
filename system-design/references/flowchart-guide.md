# Guia de Desenho e Flowchart Interativo em React

Este guia orienta o desenvolvimento e geração de diagramas de arquitetura interativos no formato de um **Artifact React**.

---

## 🎨 Design System do Flowchart

Para que o diagrama pareça profissional e premium, use cores e padrões HSL harmoniosos, e organize o layout de forma lógica (da esquerda para a direita).

### 1. Camadas e Cores (HSL/CSS)

| Camada | Função | Cor de Fundo | Borda / Destaque |
|---|---|---|---|
| **Atores** | Usuários, Aplicações Client, Web/Mobile | `hsl(210, 30%, 96%)` | `hsl(210, 50%, 60%)` |
| **API Layer** | Gateway, Load Balancer, Proxies, Auth | `hsl(280, 30%, 96%)` | `hsl(280, 50%, 65%)` |
| **Processing** | Microservices, Workers, Queues, Streams | `hsl(30, 45%, 96%)` | `hsl(30, 80%, 60%)` |
| **Data Layer** | Bancos de dados, Caches, Object Storage, CDNs | `hsl(150, 30%, 95%)` | `hsl(150, 50%, 50%)` |

### 2. Estilo de Conexões (Setas)
- Use **linhas limpas** com setas desenhadas em SVG.
- Destaque as conexões ativas ao selecionar uma caixa (ex: aumentar a espessura da linha e mudar a cor para um azul ou roxo vibrante).
- Adicione um texto (label) legível no meio da linha informando o protocolo/canal (ex: `gRPC`, `REST`, `AMQP`, `HTTPS`).

---

## 💻 Estrutura de Código React Recomendada

Abaixo está um template em React funcional e limpo para desenhar um flowchart de arquitetura interativo. Ele usa SVG e estado de seleção.

```jsx
import React, { useState } from 'react';

// Exemplo de Nós de Arquitetura
const initialNodes = [
  { id: 'client', label: 'Mobile App', layer: 'Atores', desc: 'App nativo iOS/Android em Swift/Kotlin', x: 50, y: 150 },
  { id: 'gateway', label: 'Amazon API Gateway', layer: 'API Layer', desc: 'Auth, throttling e roteamento', x: 250, y: 150 },
  { id: 'feed-api', label: 'Feed Service (Go)', layer: 'Processing', desc: 'Gera feeds de usuários a partir do cache/DB', x: 450, y: 100 },
  { id: 'post-api', label: 'Post Service (Go)', layer: 'Processing', desc: 'Cria novos posts e publica na fila', x: 450, y: 200 },
  { id: 'sqs', label: 'Post SQS Queue', layer: 'Processing', desc: 'Fila de posts para desacoplamento de escrita', x: 650, y: 200 },
  { id: 'worker', label: 'Fan-out Worker', layer: 'Processing', desc: 'Consome da fila e espalha posts no cache dos seguidores', x: 850, y: 200 },
  { id: 'redis', label: 'ElastiCache (Redis)', layer: 'Data Layer', desc: 'Armazena feeds ativos (últimos 100 posts de cada usuário)', x: 650, y: 80 },
  { id: 'rds', label: 'RDS PostgreSQL', layer: 'Data Layer', desc: 'Banco ACID primário com posts e dados relacionais', x: 1050, y: 200 }
];

// Exemplo de Conexões (Edges)
const initialEdges = [
  { from: 'client', to: 'gateway', label: 'HTTPS (REST)', protocol: 'REST' },
  { from: 'gateway', to: 'feed-api', label: 'gRPC', protocol: 'gRPC' },
  { from: 'gateway', to: 'post-api', label: 'gRPC', protocol: 'gRPC' },
  { from: 'feed-api', to: 'redis', label: 'Redis TCP', protocol: 'Cache Read' },
  { from: 'post-api', to: 'sqs', label: 'AWS SDK', protocol: 'Queue Pub' },
  { from: 'sqs', to: 'worker', label: 'Polling', protocol: 'Queue Sub' },
  { from: 'worker', to: 'redis', label: 'Redis Pipeline', protocol: 'Cache Write' },
  { from: 'worker', to: 'rds', label: 'SQL (Bulk Write)', protocol: 'DB Write' }
];

export default function ArchitectureFlowchart() {
  const [selectedNode, setSelectedNode] = useState(null);

  const handleNodeClick = (node) => {
    setSelectedNode(selectedNode?.id === node.id ? null : node);
  };

  const isConnected = (nodeId) => {
    if (!selectedNode) return false;
    if (selectedNode.id === nodeId) return true;
    return initialEdges.some(
      (edge) =>
        (edge.from === selectedNode.id && edge.to === nodeId) ||
        (edge.to === selectedNode.id && edge.from === nodeId)
    );
  };

  const getEdgeStyle = (edge) => {
    const isActive = selectedNode && (edge.from === selectedNode.id || edge.to === selectedNode.id);
    return {
      stroke: isActive ? 'hsl(250, 80%, 55%)' : 'hsl(210, 15%, 75%)',
      strokeWidth: isActive ? 3 : 1.5,
      strokeDasharray: edge.protocol.includes('Async') || edge.label.includes('Polling') ? '5,5' : 'none',
      transition: 'stroke 0.2s, stroke-width 0.2s'
    };
  };

  return (
    <div style={{ display: 'flex', flexDirection: 'column', height: '550px', fontFamily: 'sans-serif', border: '1px solid #ccc', borderRadius: '8px', overflow: 'hidden' }}>
      <div style={{ padding: '10px 16px', background: '#f5f5f5', borderBottom: '1px solid #ccc', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <h3 style={{ margin: 0 }}>Arquitetura Geral — Flowchart Interativo</h3>
        <span style={{ fontSize: '12px', color: '#666' }}>Clique em um componente para destacar conexões</span>
      </div>

      <div style={{ display: 'flex', flex: 1, position: 'relative', overflow: 'hidden' }}>
        {/* Workspace do Diagrama SVG */}
        <div style={{ flex: 1, background: '#fafafa', overflow: 'auto', padding: '20px' }}>
          <svg width="1200" height="400" style={{ pointerEvents: 'all' }}>
            <defs>
              <marker id="arrow" viewBox="0 0 10 10" refX="22" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
                <path d="M 0 0 L 10 5 L 0 10 z" fill="hsl(210, 15%, 55%)" />
              </marker>
              <marker id="arrow-selected" viewBox="0 0 10 10" refX="22" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
                <path d="M 0 0 L 10 5 L 0 10 z" fill="hsl(250, 80%, 55%)" />
              </marker>
            </defs>

            {/* Desenho das Conexões */}
            {initialEdges.map((edge, index) => {
              const fromNode = initialNodes.find((n) => n.id === edge.from);
              const toNode = initialNodes.find((n) => n.id === edge.to);
              if (!fromNode || !toNode) return null;

              const isSelected = selectedNode && (edge.from === selectedNode.id || edge.to === selectedNode.id);

              return (
                <g key={index}>
                  <line
                    x1={fromNode.x + 80}
                    y1={fromNode.y + 25}
                    x2={toNode.x + 80}
                    y2={toNode.y + 25}
                    style={getEdgeStyle(edge)}
                    markerEnd={isSelected ? "url(#arrow-selected)" : "url(#arrow)"}
                  />
                  <text
                    x={(fromNode.x + toNode.x) / 2 + 80}
                    y={(fromNode.y + toNode.y) / 2 + 18}
                    fill={isSelected ? 'hsl(250, 80%, 45%)' : '#777'}
                    style={{ fontSize: '10px', textAnchor: 'middle', fontWeight: isSelected ? 'bold' : 'normal' }}
                  >
                    {edge.label}
                  </text>
                </g>
              );
            })}

            {/* Desenho dos Nós */}
            {initialNodes.map((node) => {
              const isSel = selectedNode?.id === node.id;
              const isRelated = isConnected(node.id);
              let layerColor = '#e1f5fe';
              let borderColor = '#0288d1';

              if (node.layer === 'API Layer') { layerColor = '#f3e5f5'; borderColor = '#7b1fa2'; }
              if (node.layer === 'Processing') { layerColor = '#fff3e0'; borderColor = '#f57c00'; }
              if (node.layer === 'Data Layer') { layerColor = '#e8f5e9'; borderColor = '#388e3c'; }

              return (
                <g
                  key={node.id}
                  transform={`translate(${node.x}, ${node.y})`}
                  onClick={() => handleNodeClick(node)}
                  style={{ cursor: 'pointer' }}
                >
                  <rect
                    width="160"
                    height="50"
                    rx="6"
                    fill={layerColor}
                    stroke={isSel ? '#d32f2f' : borderColor}
                    strokeWidth={isSel ? 3 : isRelated ? 2 : 1}
                    style={{ transition: 'stroke-width 0.15s, stroke 0.15s' }}
                  />
                  <text x="80" y="22" textAnchor="middle" style={{ fontSize: '12px', fontWeight: 'bold', fill: '#333' }}>
                    {node.label}
                  </text>
                  <text x="80" y="38" textAnchor="middle" style={{ fontSize: '9px', fill: '#666' }}>
                    ({node.layer})
                  </text>
                </g>
              );
            })}
          </svg>
        </div>

        {/* Painel Lateral com Detalhes */}
        <div style={{ width: '300px', borderLeft: '1px solid #ccc', background: '#fff', padding: '16px', boxSizing: 'border-box', overflowY: 'auto' }}>
          {selectedNode ? (
            <div>
              <h4 style={{ margin: '0 0 4px 0', color: 'hsl(210, 10%, 20%)' }}>{selectedNode.label}</h4>
              <span style={{ fontSize: '11px', textTransform: 'uppercase', color: '#999', fontWeight: 'bold' }}>{selectedNode.layer}</span>
              <p style={{ fontSize: '13px', color: '#555', marginTop: '12px', lineHeight: '1.4' }}>{selectedNode.desc}</p>
            </div>
          ) : (
            <div style={{ color: '#aaa', textAlign: 'center', marginTop: '40px', fontSize: '13px' }}>
              Selecione um componente no diagrama para ver detalhes arquiteturais.
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
```
