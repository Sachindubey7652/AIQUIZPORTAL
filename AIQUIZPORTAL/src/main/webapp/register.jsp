<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // If already logged in, send to user dashboard
    if (session != null && session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
        return;
    }
    // Grab any feedback
    String errorMessage   = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AIQUIZPORTAL — Register</title>
  <style>
    /* Base reset + fonts */
    * { margin:0; padding:0; box-sizing:border-box; font-family:'Orbitron','Arial',sans-serif; }
    @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&display=swap');

    body {
      background:#0a0a1a;
      color:#00f7ff;
      height:100vh; overflow:hidden;
      display:flex; justify-content:center; align-items:center;
      perspective:1000px;
    }

    /* Starfield & particles (same as login) */
    .stars, .particles { position:fixed; top:0; left:0; width:100%; height:100%; z-index:-1; }
    .stars { background:radial-gradient(ellipse at bottom,#1B2735 0%,#090A0F 100%); overflow:hidden; }
    .star, .particle { position:absolute; border-radius:50%; pointer-events:none; }

    .star { background:#fff; animation:twinkle var(--d) infinite ease-in-out; }
    @keyframes twinkle {0%,100%{opacity:0.2;}50%{opacity:1;}}

    .particle { background:rgba(0,247,255,0.5); animation:float var(--fd) infinite ease-in-out var(--del); }

    /* Floating keyframes injected by script */

    /* Main form container */
    .form-container {
      position:relative;
      width:360px; padding:40px;
      background:rgba(10,20,40,0.7);
      border-radius:10px;
      box-shadow:0 0 30px rgba(0,247,255,0.3);
      backdrop-filter:blur(10px);
      transform-style:preserve-3d;
      transition:transform .5s ease;
      border:1px solid rgba(0,247,255,0.2);
      overflow:hidden;
    }
    .form-container::before {
      content:''; position:absolute; top:-50%; left:-50%;
      width:200%; height:200%;
      background:linear-gradient(to br,transparent 0%,rgba(0,247,255,0.1)50%,transparent 100%);
      transform:rotate(30deg); animation:shine 6s infinite linear; z-index:-1;
    }
    @keyframes shine {0%{transform:rotate(30deg) translate(-30%,-30%);}100%{transform:rotate(30deg) translate(30%,30%);} }

    .header { text-align:center; margin-bottom:30px; }
    .header h1 {
      font-size:28px; font-weight:700; letter-spacing:2px;
      background:linear-gradient(90deg,#00f7ff,#0084ff);
      -webkit-background-clip:text; background-clip:text; color:transparent;
      animation:textGlow 2s infinite alternate;
    }
    @keyframes textGlow {0%{text-shadow:0 0 5px rgba(0,247,255,0.3);}100%{text-shadow:0 0 15px rgba(0,247,255,0.7),0 0 25px rgba(0,247,255,0.4);} }
    .header p { color:rgba(0,247,255,0.7); font-size:14px; letter-spacing:1px; }

    .message { padding:10px; margin-bottom:20px; border-radius:4px; text-align:center; }
    .error   { background:#fdecea; color:#b71c1c;  }
    .success { background:#e8f5e9; color:#256029; }

    .input-group { position:relative; margin-bottom:25px; }
    .input-group i {
      position:absolute; left:15px; top:50%; transform:translateY(-50%);
      color:rgba(0,247,255,0.7); font-size:18px;
    }
    .input-group input {
      width:100%; padding:15px 20px 15px 45px;
      background:rgba(5,15,30,0.7); border:1px solid rgba(0,247,255,0.3);
      border-radius:5px; color:#00f7ff; font-size:16px; outline:none;
      transition:all .3s;
    }
    .input-group input::placeholder { color:rgba(0,247,255,0.5); }
    .input-group input:focus { border-color:#00f7ff; box-shadow:0 0 10px rgba(0,247,255,0.5); }
    .input-group .focus-line {
      position:absolute; bottom:0; left:0; width:0; height:2px;
      background:linear-gradient(90deg,#00f7ff,#0084ff); transition:width .3s;
    }
    .input-group input:focus ~ .focus-line { width:100%; }

    button {
      width:100%; padding:15px;
      background:linear-gradient(135deg,#00f7ff,#0084ff);
      border:none; border-radius:5px; color:#0a0a1a; font-size:16px;
      font-weight:700; cursor:pointer; position:relative; overflow:hidden;
      transition:all .3s; z-index:1;
    }
    button::before {
      content:''; position:absolute; top:0; left:-100%; width:100%; height:100%;
      background:linear-gradient(90deg,transparent,rgba(255,255,255,0.2),transparent);
      transition:0.5s; z-index:-1;
    }
    button:hover::before { left:100%; }
    button:hover { box-shadow:0 0 15px rgba(0,247,255,0.7); transform:translateY(-2px); }
    button:active { transform:translateY(0); }

    .bottom-link { text-align:center; margin-top:20px; font-size:14px; }
    .bottom-link a { color:rgba(0,247,255,0.7); text-decoration:none; transition:color .3s; }
    .bottom-link a:hover { color:#00f7ff; text-shadow:0 0 5px rgba(0,247,255,0.5); }

    .holo {
      position:absolute; top:0; left:0; width:100%; height:100%;
      background:linear-gradient(135deg,rgba(0,247,255,0.05)0%,rgba(0,247,255,0.1)50%,rgba(0,247,255,0.05)100%);
      opacity:0.5; z-index:-1; animation:holoMove 8s infinite linear;
    }
    @keyframes holoMove {0%{transform:translate(-50%,-50%)rotate(0);}100%{transform:translate(50%,50%)rotate(360deg);} }
  </style>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
  <div class="stars" id="stars"></div>
  <div class="particles" id="particles"></div>

  <div class="form-container" id="form">
    <div class="holo"></div>
    <div class="header">
      <h1>AIQUIZPORTAL</h1>
      <p>CREATE YOUR ACCOUNT</p>
    </div>

    <% if (errorMessage != null) { %>
      <div class="message error"><%= errorMessage %></div>
    <% } else if (successMessage != null) { %>
      <div class="message success"><%= successMessage %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/register" method="post">
      <div class="input-group">
        <i class="fas fa-user"></i>
        <input type="text" name="name" placeholder="Full Name" required>
        <div class="focus-line"></div>
      </div>
      <div class="input-group">
        <i class="fas fa-envelope"></i>
        <input type="email" name="email" placeholder="Email Address" required>
        <div class="focus-line"></div>
      </div>
      <div class="input-group">
        <i class="fas fa-lock"></i>
        <input type="password" name="password" placeholder="Password" required>
        <div class="focus-line"></div>
      </div>
      <button type="submit">REGISTER</button>
    </form>

    <div class="bottom-link">
      Already have an account? <a href="<%= request.getContextPath() %>/login.jsp">Sign In</a>
    </div>
  </div>

  <script>
    // Star & particle generators (same as login)
    const stars = document.getElementById('stars');
    for (let i=0; i<200; i++){
      let s = document.createElement('div');
      s.className='star';
      let size = Math.random()*2+1;
      s.style.width = s.style.height = size+'px';
      s.style.left = Math.random()*100+'%';
      s.style.top  = Math.random()*100+'%';
      s.style.setProperty('--d', Math.random()*5+3+'s');
      s.style.animationDelay = Math.random()*5+'s';
      stars.appendChild(s);
    }
    const particles = document.getElementById('particles');
    for (let i=0; i<30; i++){
      let p = document.createElement('div');
      p.className='particle';
      let size = Math.random()*4+1; p.style.width=p.style.height=size+'px';
      p.style.left=Math.random()*100+'%'; p.style.top=Math.random()*100+'%';
      p.style.setProperty('--fd', Math.random()*10+5+'s');
      p.style.setProperty('--del', Math.random()*5+'s');
      particles.appendChild(p);
    }
    // Floating keyframes
    const style = document.createElement('style');
    style.innerHTML = `
      @keyframes float {
        0%,100% {transform:translate(0,0);}
        25% {transform:translate(${Math.random()*100-50}px,${Math.random()*100-50}px);}
        50% {transform:translate(${Math.random()*100-50}px,${Math.random()*100-50}px);}
        75% {transform:translate(${Math.random()*100-50}px,${Math.random()*100-50}px);}
      }
    `;
    document.head.appendChild(style);

    // 3D tilt on form
    const form = document.getElementById('form');
    form.addEventListener('mousemove', e=>{
      const x = (window.innerWidth/2 - e.pageX)/25;
      const y = (window.innerHeight/2 - e.pageY)/25;
      form.style.transform = `rotateY(${x}deg) rotateX(${y}deg)`;
    });
    form.addEventListener('mouseleave', ()=> form.style.transform='rotateY(0) rotateX(0)');
  </script>
</body>
</html>
